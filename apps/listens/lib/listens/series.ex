defmodule Listens.Series do
  defmacro series_day(value) do
    quote do
      fragment(
        """
        SELECT generate_series(
          current_date - interval '1 day' * ?,
          current_date,
          '1 day'
        )::date AS d
        """,
        unquote(value)
      )
    end
  end
end
