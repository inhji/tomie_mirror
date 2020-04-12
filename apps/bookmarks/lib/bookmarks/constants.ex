defmodule Bookmarks.Constants do
  defmacro __using__(_) do
    quote do
      @post_type "bookmark"

      @bookmark_created "Bookmark created!"
      @bookmark_updated "Bookmark updated!"
      @bookmark_deleted "Bookmark deleted!"
    end
  end
end
