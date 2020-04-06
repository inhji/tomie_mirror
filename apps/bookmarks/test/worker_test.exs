defmodule WorkerTest do
  use ExUnit.Case
  import Mock

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)
  end

  @github_response {:ok, %{status_code: 200, body: "<html></html>"}}

  test "perform/1" do
    with_mock HTTPoison, get: fn _url, _headers -> @github_response end do
      {:ok, tag} = Tags.create_tag(%{name: "github", rules: "source::contains::github"})
      {:ok, bookmark} = Bookmarks.create_bookmark(%{source: "https://github.com"})

      Bookmarks.Worker.perform(bookmark)

      updated_bookmark = Bookmarks.get_bookmark!(bookmark.id)

      assert [tag] == updated_bookmark.tags
    end
  end
end
