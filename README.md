![Anka](banner.png)

Anka and its binding projects provide base model and macros to increase modularity of Elixir projects with DRY principle.

[![Hex Version](https://img.shields.io/hexpm/v/anka.svg?style=flat-square)](https://hex.pm/packages/anka) [![Docs](https://img.shields.io/badge/api-docs-orange.svg?style=flat-square)](https://hexdocs.pm/anka) [![Hex downloads](https://img.shields.io/hexpm/dt/anka.svg?style=flat-square)](https://hex.pm/packages/anka) [![GitHub](https://img.shields.io/badge/vcs-GitHub-blue.svg?style=flat-square)](https://github.com/elixir-anka/anka) [![MIT License](https://img.shields.io/hexpm/l/anka.svg?style=flat-square)](LICENSE.txt)

---

</br>

**`Installation`**


The package is [available in Hex](https://hex.pm/packages/anka), it can be installed
by adding `:anka` to your list of dependencies in `mix.exs`:

```elixir
def application() do
	[
		extra_applications: [
			:anka,
		],
	]
end

def deps() do
	[
		{:anka, "~> 0.1.0"},
	]
end
```
