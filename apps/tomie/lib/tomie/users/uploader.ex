defmodule Tomie.Users.Uploader do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  @versions [:thumb, :large]

  # Whitelist file extensions:
  def validate({_file, _scope}), do: true

  def transform(:large, _) do
    {:convert, "-strip -thumbnail 500x500^ -gravity center -extent 500x500 -format png", :png}
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 150x150^ -gravity center -extent 150x150 -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, {_file, _scope}) do
    "avatar-#{version}"
  end

  # Override the storage directory:
  def storage_dir(_, _) do
    "user"
  end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(_version, _scope) do
    "/images/user/avatar.png"
  end
end