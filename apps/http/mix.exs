defmodule Http.MixProject do
  use Mix.Project

  def project do
    [
      app: :http,
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
      mod: {Http.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cachex, "~> 3.2"},
      {:floki, "~> 0.29.0"},
      {:httpoison, "~> 1.6"},
      {:open_graph_extended, git: "https://git.inhji.de/inhji/open_graph.git"}
    ]
  end
end
