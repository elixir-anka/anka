defmodule Anka.Generator do

	@macrocallback generate_from_model(model :: Module, opts :: Keyword) :: Macro


	@doc ~S"""
	Helps to create a custom purpose generator.

	See: [`ALTSTD.Inheritance.__using__/1`](https://hexdocs.pm/altstd/ALTSTD.Inheritance.html#__using__/1)

	## Examples

		iex> defmodule StructGenerator do
		...>
		...> 	use Anka.Generator
		...>
		...> 	@impl Anka.Generator
		...> 	defmacro generate_from_model(model, _opts \\ []) do
		...>
		...> 		model_expanded = Macro.expand(model, __CALLER__)
		...>
		...> 		defstruct_opts = Anka.Model.Interpreter.get_opt(model_expanded, :"struct.fields", default: [])
		...> 			|> Keyword.keys()
		...> 			|> Enum.map(fn field_id -> {field_id, nil} end)
		...> 			|> Keyword.new()
		...>
		...> 		quote do
		...>
		...> 			@before_compile unquote(__MODULE__)
		...>
		...> 			@model 			unquote(model)
		...>
		...> 			@model_expanded unquote(model_expanded)
		...>
		...> 			@defstruct 		unquote(defstruct_opts)
		...>
		...> 			def new(opts \\ [])
		...> 			when is_list(opts)
		...> 			do
		...>				struct(__MODULE__, opts)
		...> 			end
		...>
		...> 		end
		...>
		...> 	end
		...>
		...> 	defmacro __before_compile__(_env) do
		...>
		...> 		quote do
		...>
		...> 			defstruct @defstruct
		...>
		...> 		end
		...>
		...> 	end
		...>
		...> end
		...>
		...> defmodule Models.Post do
		...>
		...> 	use Anka.Model, [
		...> 		meta: [
		...> 			singular: :post,
		...> 			plural: :posts,
		...> 		],
		...> 		struct: [
		...> 			fields: [
		...> 				title: [
		...> 					type: :string,
		...> 				],
		...> 				body: [
		...> 					type: :string,
		...> 				],
		...> 			],
		...> 		],
		...> 	]
		...>
		...> end
		...>
		...> defmodule Structs.Post do
		...>
		...> 	require StructGenerator
		...>
		...> 	StructGenerator.generate_from_model(Models.Post)
		...>
		...> end
		...>
		...> post = Structs.Post.new(title: "First Post", body: "Hello, world!")
		...> post.title
		"First Post"
	"""
	@since "0.1.0"
	defmacro __using__(_opts \\ []) do

		quote do

			use ALTSTD.Inheritance,
				module: Anka.Generator
		
			@behaviour Anka.Generator

		end

	end

end
