defmodule ElixirObservability.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_observability,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: true,
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirObservability.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:castore, "~> 0.1.0"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:plug_checkup, "~> 0.6.0"},
      {:poison, "~> 4.0"},
      {:cors_plug, "~> 2.0"},
      {:timex, "~> 3.0"},
      {:ecto_sql, "~> 3.9"},
      {:postgrex, "~> 0.16"},
      {:finch, "~> 0.13"},
      {:logger_file_backend, "~> 0.0.13"},

      {:excoveralls, "~> 0.10", only: :test},
      {:ex_unit_sonarqube, "~> 0.1", only: :test},
    ]
  end
end