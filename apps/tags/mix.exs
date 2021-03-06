defmodule Tags.MixProject do
  use Mix.Project

  def project do
    [
      app: :tags,
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
      {:ecto_sql, "~> 3.1"},
      {:ecto_autoslug_field, "~> 2.0"},
      {:excoveralls, "~> 0.13.0", only: :test},
      {:db, in_umbrella: true}
    ]
  end
end
