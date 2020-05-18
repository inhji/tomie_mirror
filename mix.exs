defmodule Tomie.Umbrella.MixProject do
  use Mix.Project

  @version "0.47.3"

  def project do
    [
      apps_path: "apps",
      version: @version,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      releases: [
        tomie: [
          applications: [
            tomie: :permanent,
            tomie_web: :permanent,
            db: :permanent,
            bookmarks: :permanent,
            scraper: :permanent,
            tags: :permanent,
            listens: :permanent,
            http: :permanent
          ]
        ]
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:git_ops, "~> 2.0.0", only: [:dev, :test]}
    ]
  end
end
