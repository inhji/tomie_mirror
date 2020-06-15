defmodule Listens.MixProject do
  use Mix.Project

  def project do
    [
      app: :listens,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Listens.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cachex, "~> 3.2"},
      {:waffle, "~> 1.1"},
      {:waffle_ecto, "~> 0.0.9"},
      {:phoenix_pubsub, "~> 2.0"},
      {:ecto_sql, "~> 3.1"},
      {:http, in_umbrella: true},
      {:db, in_umbrella: true}
    ]
  end
end
