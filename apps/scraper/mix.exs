defmodule Scraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :scraper,
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
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:open_graph_extended, git: "https://git.inhji.de/inhji/open_graph.git"},
      {:httpoison, "~> 1.6"},
      {:excoveralls, "~> 0.12.3", only: :test},
      {:http, in_umbrella: true},
      {:floki, "~> 0.26.0"}
    ]
  end
end
