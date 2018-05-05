defmodule Anka.MixProject do

    use Mix.Project

    @version "0.1.0"

	@github_url "https://github.com/elixir-anka/anka"

    def project() do
        [
            app: :anka,
            version: @version,
			description: """
			Anka and its binding projects provide base model and macros to increase modularity of Elixir projects with DRY principle.
			"""
			|> String.trim(),
			package: __MODULE__.package(),
            elixir: "~> 1.6",
			elixirc_paths: __MODULE__.elixirc_paths(Mix.env()),
            start_permanent: Mix.env() == :prod,
            deps: deps(),
			aliases: __MODULE__.aliases(),
        ]
		|> Keyword.put(:docs, __MODULE__.docs())
    end

	def package() do
		[
			maintainers: [
				"Ertuğrul Keremoğlu <ertugkeremoglu@gmail.com>",
			],
			licenses: [
				"MIT",
			],
			files: [
				"lib",
				".formatter.exs",
				"mix.exs",
				"logo.png",
				"banner.png",
				"README.md",
				"LICENSE.txt",
			],
			links: %{
				"GitHub" => @github_url,
			},
		]
	end

	def docs() do
		[
			name: "Anka",
			logo: "logo.png",
			source_ref: "v#{@version}",
			source_url: @github_url,
            main: "Anka",
		]
	end

    # Run "mix help compile.app" to learn about applications.
    def application() do
        [
            mod: {Anka.Application, []},
            extra_applications: __MODULE__.extra_applications(Mix.env()),
        ]
    end

	def extra_applications() do
		[
			:logger,
		]
	end

	def extra_applications(_env) do
		__MODULE__.extra_applications()
	end

	def elixirc_paths() do
		[
			"lib",
		]
	end

	def elixirc_paths(:test) do
		__MODULE__.elixirc_paths()
		++
		[
			"test/support",
		]
	end

	def elixirc_paths(_env) do
		__MODULE__.elixirc_paths()
	end

	def aliases() do
		[]
	end

    # Run "mix help deps" to learn about dependencies.
    defp deps() do
        [
			{:altstd, "~> 0.0.1"},
			{:ex_doc, "~> 0.16", only: :dev, runtime: false},
        ]
    end

end
