defmodule Anka.Model.Interpreter do
	@moduledoc """
	Helps to interpret `Anka.Model` based models to extract their opts.
	"""

	@callback 			get_opt(module_or_keyword :: (Module | Keyword), key_path :: List | atom) :: any

	@callback 			get_opt(module_or_keyword :: (Module | Keyword), key_path :: List | atom, opts :: Keyword) :: any
	
	@optional_callbacks get_opt: 2, get_opt: 3


	@doc ~S"""
	Helps to create a custom purpose interpreter.

	See: [`ALTSTD.Inheritance.__using__/1`](https://hexdocs.pm/altstd/ALTSTD.Inheritance.html#__using__/1)

	## Examples

		iex> defmodule CustomInterpreter do
		...>
		...> 	use Anka.Model.Interpreter
		...>
		...> end
		...>
		...> CustomInterpreter.get_opt([a: [b: [c: [d: :e]]]], :"a.b.c.d")
		:e
	"""
	@since "0.1.0"
	defmacro __using__(_opts \\ []) do

		quote do

			use ALTSTD.Inheritance,
				module: Anka.Model.Interpreter

			@behaviour Anka.Model.Interpreter

		end
		
	end


	@doc ~S"""
	Gets the value for a specific key path.

	If key does not exist, return the default value.

	## Options

	- `:default` - Used for setting default value. Default: `nil`
	- `:splitter` - Used for setting nest splitter. Default: `"."`

	See: [`ALTSTD.Keyword.get/3`](https://hexdocs.pm/altstd/ALTSTD.Keyword.html#get/3)

	## Examples

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], :"a.b.c.d")
		:e

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], [:a, :b, :c, :d])
		:e

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], :"a.b.c")
		[d: :e]

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], :"a.b.c.d.e")
		nil

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], :"a->b->c->d", splitter: "->")
		:e

		iex> Anka.Model.Interpreter.get_opt([a: [b: [c: [d: :e]]]], :"a.b.c.d.e", default: :unknown)
		:unknown

		iex> defmodule Tweet do
		...>
		...> 	use Anka.Model, [
		...> 		meta: [
		...> 			singular: :tweet,
		...> 			plural: :tweets,
		...> 		],
		...> 		struct: [
		...> 			fields: [
		...> 				body: [
		...> 					type: :string,
		...> 				],
		...> 			],
		...> 		],
		...> 	]
		...>
		...> end
		...>
		...> Anka.Model.Interpreter.get_opt(Tweet, :"struct.fields.body.type") == Anka.Model.Interpreter.get_opt(Tweet.opts(), :"struct.fields.body.type")
		true
	"""
	@since "0.1.0"
	@spec get_opt(module_or_keyword :: (Module | Keyword), key_path :: List | atom, opts :: Keyword) :: any
	def get_opt(module_or_keyword, key_path, opts \\ [])


	@since "0.1.0"
	def get_opt(module_or_keyword, key_path, opts)
	when is_atom(module_or_keyword)
	do
		__MODULE__.get_opt(module_or_keyword.opts(), key_path, opts)
	end


	@since "0.1.0"
	def get_opt(module_or_keyword, key_path, opts)
	when is_list(module_or_keyword)
	do
		ALTSTD.Keyword.get(module_or_keyword, key_path, opts)
	end
	
end
