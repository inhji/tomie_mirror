defmodule TomieWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :tomie_web,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TomieWeb.Application, []},
      extra_applications: [:logger, :runtime_tools, :uuid]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.0"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.12.0"},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:phoenix_form_awesomplete, "~> 0.1"},
      {:phoenix_active_link, "~> 0.3.0"},
      {:chartkick, "~> 0.4.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.2"},
      {:pow, "~> 1.0.19"},
      {:excoveralls, "~> 0.12.3", only: :test},
      {:timex, "~> 3.5"},
      {:telemetry_poller, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:tomie, in_umbrella: true},
      {:bookmarks, in_umbrella: true},
      {:notes, in_umbrella: true},
      {:tags, in_umbrella: true},
      {:db, in_umbrella: true},
      {:listens, in_umbrella: true}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, we extend the test task to create and migrate the database.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      # test: ["test"]
    ]
  end
end
