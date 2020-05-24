defmodule TomieWeb.NoteLive.Navigation do
  def in_bounds?(new_value, list) do
    lower_bound = 0
    upper_bound = Enum.count(list) - 1

    cond do
      new_value < lower_bound -> false
      new_value > upper_bound -> false
      true -> true
    end
  end

  def ensure_in_bounds(socket, new_value, list) do
    if in_bounds?(new_value, list) do
      new_value
    else
      socket.assigns.selected
    end
  end
end
