defmodule Anka.Generator do
  @moduledoc ~S"""
  Anka generators derive new structures from Anka models.

  A generator simply must have `generate/1` and `generate/2` macros
  which will be used while deriving new structures from model definitions.

  ## Examples

      iex> defmodule StructGenerator do
      ...>   @behaviour Anka.Generator
      ...>
      ...>   @impl Anka.Generator
      ...>   defmacro generate(model, _opts \\ []) do
      ...>     model_expanded = Macro.expand(model, __CALLER__)
      ...>
      ...>     definition =
      ...>       Anka.Model.spec(model_expanded, [:struct, :fields], default: [])
      ...>       |> Enum.map(fn key ->
      ...>         {key, nil}
      ...>       end)
      ...>       |> Keyword.new()
      ...>
      ...>     quote do
      ...>       @before_compile unquote(__MODULE__)
      ...>
      ...>       @definition unquote(definition)
      ...>     end
      ...>   end
      ...>
      ...>   defmacro __before_compile__(_env) do
      ...>     quote do
      ...>       defstruct @definition
      ...>     end
      ...>   end
      ...> end
      ...>
      ...> defmodule UserModel do
      ...>   use Anka.Model, [
      ...>     name: [
      ...>       singular: :user,
      ...>       plural: :users
      ...>     ],
      ...>     struct: [
      ...>       fields: [
      ...>         :id,
      ...>         :username
      ...>       ]
      ...>     ]
      ...>   ]
      ...> end
      ...>
      ...> defmodule User do
      ...>   require StructGenerator
      ...>   StructGenerator.generate(UserModel)
      ...> end
      ...>
      ...> %User{id: 1, username: "anka"}
      %User{id: 1, username: "anka"}

  """
  @moduledoc since: "0.1.1"

  @doc since: "0.1.1"
  @macrocallback generate(model :: Anka.Model.t()) :: Macro

  @doc since: "0.1.1"
  @macrocallback generate(model :: Anka.Model.t(), opts :: Keyword) :: Macro
end
