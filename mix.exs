defmodule Tomie.Umbrella.MixProject do
  use Mix.Project

  @version "0.65.0"

  def project do
    [
      apps_path: "apps",
      version: @version,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        tomie: [
          applications: [
            bookmarks: :permanent,
            db: :permanent,
            http: :permanent,
            indie: :permanent,
            listens: :permanent,
            scraper: :permanent,
            tags: :permanent,
            tomie: :permanent,
            tomie_web: :permanent,
            wiki: :permanent
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
