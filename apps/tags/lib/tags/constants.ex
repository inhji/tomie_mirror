defmodule Tags.Constants do
  defmacro __using__(_) do
    quote do
      @tag_created "Tag created!"
    end
  end
end
