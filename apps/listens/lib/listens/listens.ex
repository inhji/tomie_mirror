defmodule Listens.Listens do
  import Ecto.Query, warn: false

  alias Listens.Listens.Listen

  def list_listens() do
    Listen
    |> order_by(desc: :listened_at)
    |> limit(20)
    |> Db.Repo.all()
    |> Db.Repo.preload([:artist, :album, :track])
  end
end
