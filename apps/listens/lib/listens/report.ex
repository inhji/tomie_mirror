defmodule Listens.Report do
  import Ecto.Query, warn: false

  alias Listens.Artists.Artist
  alias Listens.Albums.Album
  alias Listens.Listens.Listen

  def top(model, limit, time_diff) when model in [Album, Artist] do
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
        limit: ^limit
    )
  end

  def sparkline() do
    oldest = get_oldest_listen()
    newest = get_newest_listen()
    per_month = listens_per_month()

    Listens.Sparkline.create(per_month, oldest, newest)
  end

  def count_listens_query(model) when model in [Album, Artist] do
    from a in model,
      left_join: l in assoc(a, :listens),
      group_by: a.id,
      order_by: [desc: count(a.id)],
      select: %{id: a.id, listens: count(a.id)}
  end

  def offset([{unit, value}]) when unit in [:days, :weeks, :months, :years] do
    Timex.shift(DateTime.utc_now(), [{unit, value}])
  end

  def listens_per_month() do
    Db.Repo.all(
      from l in listens_per_month_query(),
        where: l.listened_at > ^offset(years: -1)
    )
  end

  defp listens_per_month_query do
    Listen
    |> select([l], [count(l.id), fragment("date_trunc('month', ?)", l.listened_at)])
    |> order_by([l], fragment("date_trunc('month', ?)", l.listened_at))
    |> group_by([l], fragment("date_trunc('month', ?)", l.listened_at))
  end

  def get_oldest_listen() do
    Listen
    |> order_by(asc: :listened_at)
    |> where([l], l.listened_at > ^offset(years: -1))
    |> limit(1)
    |> Db.Repo.one!()
  end

  def get_newest_listen() do
    Listen
    |> order_by(desc: :listened_at)
    |> limit(1)
    |> Db.Repo.one!()
  end
end
