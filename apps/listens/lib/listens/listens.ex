defmodule Listens.Listens do
  import Ecto.Query, warn: false

  alias Listens.Listens.Listen

  def list_listens(limit \\ 20) do
    Listen
    |> order_by(desc: :listened_at)
    |> limit(^limit)
    |> Db.Repo.all()
    |> Db.Repo.preload([:artist, :album, :track])
  end
end
