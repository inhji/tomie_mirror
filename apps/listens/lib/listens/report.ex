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

  def listens_within_range(range) do
    q =
      from l in Listen,
        where: l.listened_at > ^offset(range),
        preload: [:artist, :album]

    Db.Repo.all(q)
  end

  def offset([{unit, value}]) when unit in [:days, :weeks, :months, :years] do
    Timex.shift(DateTime.utc_now(), [{unit, value}])
  end
end
