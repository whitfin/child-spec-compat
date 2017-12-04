defmodule ChildSpecCompat.Mixfile do
  use Mix.Project

  # Constants for repository information
  @url_docs "http://hexdocs.pm/child-spec-compat"
  @url_github "https://github.com/whitfin/child-spec-compat"

  # Project specification
  def project do
    [
      app: :child_spec_compat,
      name: "child-spec-compat",
      description: "Compatibility macros for Elixir v1.5+ child specifications",
      package: %{
        files: [
          "lib",
          "mix.exs",
          "LICENSE"
        ],
        licenses: [ "MIT" ],
        links: %{
          "Docs" => @url_docs,
          "GitHub" => @url_github
        },
        maintainers: [ "Isaac Whitfield" ]
      },
      version: "1.0.0",
      elixir: "~> 1.2",
      deps: deps(),
      docs: [
        source_ref: "master",
        source_url: @url_github
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
