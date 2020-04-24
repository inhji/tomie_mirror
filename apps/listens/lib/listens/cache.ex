defmodule Listens.Cache do
  def try_get(cache, key, default) do
    case Cachex.exists?(cache, key) do
      {:ok, true} ->
        Cachex.get!(cache, key)

      _ ->
        Cachex.put(cache, key, default)
        default
    end
  end

  def try_put(cache, key, value) do
    case Cachex.exists?(cache, key) do
      {:ok, true} ->
        Cachex.update(cache, key, value)

      _ ->
        Cachex.put(cache, key, value)
    end
  end
end
