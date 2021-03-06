defmodule BernardApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bernard_api,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BernardApi.Application, []},
      extra_applications: [:bernard_core, :logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # {:absinthe_ecto, "~> 0.1.0"},
      {:absinthe_phoenix, "~> 1.4.0"},
      {:absinthe_plug, "~> 1.4"},
      {:bernard_core, in_umbrella: true},
      {:comeonin, "~> 4.0"},
      {:cors_plug, "~> 1.5"},
      {:cowboy, "~> 1.0"},
      # {:gettext, "~> 0.11"},
      {:guardian, "~> 1.0"},
      {:httpoison, "~> 1.0"},
      {:kronky, "~> 0.5.0"},
      {:pbkdf2_elixir, "~> 0.12"},
      {:phoenix, "~> 1.3.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
    ]
  end
end
