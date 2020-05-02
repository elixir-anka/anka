defmodule Anka.MixProject do
  use Mix.Project

  @version "0.1.2"

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
      source_url: source_url(),
      package: package(),
      docs: docs(),
      preferred_cli_env: preferred_cli_env(),
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
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

  defp preferred_cli_env do
    [
      docs: :docs
    ]
  end

  defp package do
    [
      maintainers: [
        "Ertuğrul Keremoğlu <ertugkeremoglu@gmail.com>"
      ],
      licenses: [
        "MIT"
      ],
      links: %{
        "GitHub" => source_url()
      },
      files: [
        "assets",
        "lib",
        "mix.exs",
        "LICENSE.txt",
        "README.md",
        ".formatter.exs"
      ]
    ]
  end

  defp docs() do
    [
      name: "Anka",
      main: "Anka",
      logo: "assets/logo.png",
      source_url: source_url(),
      source_ref: "v#{@version}",
      formatters: [
        "html",
        "epub"
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

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21.3", only: :docs},
      {:inch_ex, "~> 2.0", only: :docs}
    ]
  end
end
