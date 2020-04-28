defmodule Listens.Report do
  import Ecto.Query, warn: false

  alias Listens.Artists.Artist
  alias Listens.Albums.Album
  alias Listens.Listens.Listen

  def top(model, limit, time_diff, preloads \\ []) when model in [Album, Artist] do
    sq =
      from [a, l] in count_listens_query(model),
        where: l.listened_at > ^offset(time_diff),
        limit: ^limit

    Db.Repo.all(
      from a in model,
        join: s in subquery(sq),
        on: a.id == s.id,
        select: %{model: a, listens: s.listens},
        order_by: [desc: s.listens],
        limit: ^limit,
        preload: ^preloads
    )
  end

  def count_listens_query(model) when model in [Album, Artist] do
    from a in model,
      left_join: l in assoc(a, :listens),
      group_by: a.id,
      order_by: [desc: count(a.id)],
      select: %{id: a.id, listens: count(a.id)}
  end

  def listens_over_time(format, time_diff) do
    Listen
    |> group_by([l], fragment("to_char(?, ?)", l.listened_at, "YYYY-mm-dd"))
    |> select([l], %{
      count: count(l.id),
      date: fragment("to_char(?, ?)", l.listened_at, "YYYY-mm-dd")
    })
    |> where([l], l.listened_at > ^offset(time_diff))
    |> order_by([l], fragment("to_char(?, ?)", l.listened_at, "YYYY-mm-dd"))
    |> Db.Repo.all()
  end

  def offset([{unit, value}]) when unit in [:days, :weeks, :months, :years] do
    Timex.shift(DateTime.utc_now(), [{unit, value}])
  end
end
