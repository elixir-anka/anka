defmodule Anka.MixProject do
  use Mix.Project

  @version "0.1.1"

  @description """
  Anka and its binding projects provide base model structure and macros
  to increase modularity of Elixir projects with DRY principle.
  """

  @source_url "https://github.com/elixir-anka/anka"

  def version do
    @version
  end

  def description do
    @description
  end

  def source_url() do
    @source_url
  end

  def project do
    [
      app: :anka,
      version: version(),
      description: description(),
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger
      ]
    ]
  end

  defp elixirc_paths() do
    [
      "lib"
    ]
  end

  defp elixirc_paths(:test) do
    elixirc_paths() ++
      [
        "test/support"
      ]
  end

  defp elixirc_paths(_env) do
    elixirc_paths()
  end

  def docs() do
		[
      name: "Anka",
      main: "Anka",
			logo: "logo.png",
			source_ref: "v#{@version}",
			source_url: source_url(),
		]
	end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21.3", only: :docs},
      {:inch_ex, "~> 2.0", only: :docs}
    ]
  end
end
