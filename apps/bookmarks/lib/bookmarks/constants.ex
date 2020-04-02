defmodule Bookmarks.Constants do
  defmacro __using__(_) do
    quote do
      @post_type "bookmark"

      @bookmark_created "Bookmark created!"
    end
  end
end
