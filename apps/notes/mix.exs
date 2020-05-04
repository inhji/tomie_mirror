defmodule Notes.MixProject do
  use Mix.Project

  def project do
    [
      app: :notes,
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
      extra_applications: [:logger],
      mod: {Notes.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:earmark, "~> 1.4"},
      {:closure_table, git: "https://git.inhji.de/inhji/closure_table.git", branch: "testing"},
      {:db, in_umbrella: true}
    ]
  end
end
