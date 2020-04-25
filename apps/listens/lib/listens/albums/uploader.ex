defmodule Listens.Albums.Uploader do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @versions [:thumb, :large]

  # Whitelist file extensions:
  def validate({_file, _scope}), do: true

  def transform(:large, _) do
    {:convert, "-strip -thumbnail 500x500^ -gravity center -extent 500x500 -format png", :png}
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, {_file, scope}) do
    "#{scope.msid}_#{version}"
  end

  # Override the storage directory:
  def storage_dir(_, _) do
    "uploads/listens/album"
  end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(_version, _scope) do
    "images/listens/album.png"
  end
end
