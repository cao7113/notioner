defmodule Notioner.MixProject do
  use Mix.Project

  @version "0.1.4"
  @source_url "https://github.com/cao7113/notioner"

  def project do
    [
      app: :notioner,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      description: "daily mix helper tasks",
      source_url: @source_url,
      homepage_url: @source_url,
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  # for handy dev testing
  defp elixirc_paths(:dev), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5.8"},
      {:bandit, "~> 1.0", only: [:test]},
      {:git_ops, "~> 2.6.1", only: [:dev]}
    ]
  end

  # hex package metadata as https://hex.pm/docs/publish
  def package do
    [
      # This option is only needed when you don't want to use the OTP application name
      licenses: ["Apache-2.0"],
      maintainers: ["cao7113"],
      links: %{
        "GitHub" => @source_url,
        "Docs" => "https://hexdocs.pm/notioner"
      },
      files: ["lib", "config", "mix.exs", "README.md", "CHANGELOG.md"]
    ]
  end
end
