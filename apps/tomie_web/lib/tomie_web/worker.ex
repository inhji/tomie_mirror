defmodule TomieWeb.Worker do
  def run(entity) do
    disable_workers = Application.get_env(:tomie_web, :disable_workers, false)

    unless disable_workers do
      do_run(entity)
    end
  end

  defp do_run(%Bookmarks.Bookmark{} = bookmark) do
    Que.add(Bookmarks.Worker, bookmark)
  end
end
