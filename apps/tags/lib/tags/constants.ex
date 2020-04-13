defmodule Tags.Constants do
  defmacro __using__(_) do
    quote do
      @tag_created "Tag created!"
      @tag_updated "Tag updated!"
      @tag_deleted "Tag deleted!"
    end
  end
end
