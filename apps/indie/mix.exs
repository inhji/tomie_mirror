defmodule Indie.MixProject do
  use Mix.Project

  def project do
    [
      app: :indie,
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
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bookmarks, in_umbrella: true},
      {:http, in_umbrella: true},
      {:oban, "~> 1.2"},
      {:plug_micropub, "~> 0.1.0"},
      {:webmentions, "~> 0.4.2"}
    ]
  end
end
