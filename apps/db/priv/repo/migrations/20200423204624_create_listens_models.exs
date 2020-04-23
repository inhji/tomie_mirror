defmodule Db.Repo.Migrations.CreateListensModels do
  use Ecto.Migration

  def change do
    # ARTISTS

    create table(:artists) do
      add :name, :string
      add :image, :string

      add :discogs_id, :integer
      add :mbid, :string
      add :msid, :string

      timestamps()
    end

    create index(:artists, :msid)

    # ALBUMS

    create table(:albums) do
      add :name, :string
      add :image, :string

      add :mbid, :string
      add :msid, :string
      add :discogs_id, :integer

      add :artist_id, references(:artists, on_delete: :nothing)

      timestamps()
    end

    create index(:albums, :artist_id)
    create index(:albums, :msid)

    # TRACKS

    create table(:tracks) do
      add :name, :string
      add :album_id, references(:albums, on_delete: :nothing)
      add :artist_id, references(:artists, on_delete: :nothing)

      timestamps()
    end

    create index(:tracks, [:album_id])
    create index(:tracks, [:artist_id])

    # LISTENS

    create table(:listens) do
      add :listened_at, :timestamptz
      add :track_id, references(:tracks, on_delete: :nothing)
      add :artist_id, references(:artists, on_delete: :nothing)
      add :album_id, references(:albums, on_delete: :nothing)

      timestamps()
    end

    create index(:listens, [:track_id])
    create index(:listens, [:album_id])
    create index(:listens, [:artist_id])
  end
end
