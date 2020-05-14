defmodule Listens.Report do
  import Ecto.Query, warn: false
  import Listens.Series

  alias Listens.Artists.Artist
  alias Listens.Albums.Album
  alias Listens.Listens.Listen

  def top(model, limit, time_diff, opts \\ []) when model in [Album, Artist] do
    preloads = opts[:preloads] || []

    listen_query =
      from [a, l] in count_listens_query(model),
        where: l.listened_at > ^offset(time_diff),
        limit: ^limit

    query =
      from a in model,
        join: s in subquery(listen_query),
        on: a.id == s.id,
        select: %{model: a, listens: s.listens},
        order_by: [desc: s.listens],
        limit: ^limit,
        preload: ^preloads

    Db.Repo.all(query)
  end

  def by_day(artist_id, time_diff) do
    Db.Repo.all(listens_per_day_query(artist_id, time_diff))
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

  def listens_per_day_query(artist_id, [{range, value}]) when range in [:days, :weeks, :months] do
    final_value = value - 1

    from(l in Listen,
      right_join: day in series_day(^final_value),
      on: day.d == fragment("date(?)", l.listened_at) and l.artist_id == ^artist_id,
      group_by: day.d,
      order_by: day.d,
      select: [
        fragment("date(?)", day.d),
        count(l.id)
      ]
    )
  end

  def offset([{unit, value}]) when unit in [:days, :weeks, :months, :years] do
    Timex.shift(DateTime.utc_now(), [{unit, value}])
  end
end
