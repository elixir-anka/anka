defmodule Anka.Model do

	@callback opts() :: []


	@doc ~S"""
	Generates an `Anka.Model` from keywords.

	## Examples

		iex> defmodule Post do
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
		...> Anka.Model.Interpreter.get_opt(Post, :"struct.fields.title.type")
		:string
		
	"""
	@since "0.1.0"
	defmacro __using__(opts \\ []) do

		quote do

			@behaviour Anka.Model


			@impl Anka.Model
			def opts() do
				unquote(opts)
			end

		end

	end

end
