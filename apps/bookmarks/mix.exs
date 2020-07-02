defmodule Bookmarks.MixProject do
  use Mix.Project

  def project do
    [
      app: :bookmarks,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Bookmarks.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:oban, "~> 1.2"},
      {:earmark, "~> 1.4"},
      {:ecto_sql, "~> 3.1"},
      {:phoenix_pubsub, "~> 2.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:excoveralls, "~> 0.13.0", only: :test},
      {:db, in_umbrella: true},
      {:tags, in_umbrella: true},
      {:scraper, in_umbrella: true},
      {:webmentions, "~> 0.4.2"}
    ]
  end
end
