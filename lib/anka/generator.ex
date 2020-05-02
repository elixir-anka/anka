defmodule Anka.Generator do
  @moduledoc ~S"""
  Anka generators derive new structures from Anka models.

  A generator simply must have `generate/1` and `generate/2` macros
  which will be used while deriving new structures from model definitions.

  ## Examples

  ```elixir
  defmodule Generator.Struct do
    @behaviour Anka.Generator

    @impl Anka.Generator
    defmacro generate(model, _opts \\ []) do
      model_expanded = Macro.expand(model, __CALLER__)

      definition =
        Anka.Model.spec(model_expanded, [:struct, :fields], default: [])
        |> Enum.map(fn
          {key, field_spec} ->
            default_value = Anka.Model.spec(field_spec, [:opts, :default], default: [])
            {key, default_value}

          key ->
            {key, nil}
        end)
        |> Keyword.new()

      quote do
        @before_compile unquote(__MODULE__)

        @definition unquote(definition)
      end
    end

    defmacro __before_compile__(_env) do
      quote do
        defstruct @definition
      end
    end
  end
  ```

  ```elixir
  defmodule Struct.Document do
    require Generator.Struct,
      as: StructGenerator

    StructGenerator.generate(Model.Document)
  end
  ```

      iex> %Struct.Document{}
      %Struct.Document{id: nil, content: ""}
  """
  @moduledoc since: "0.1.1"

  @doc since: "0.1.1"
  @macrocallback generate(model :: Anka.Model.t()) :: Macro

  @doc since: "0.1.1"
  @macrocallback generate(model :: Anka.Model.t(), opts :: Keyword) :: Macro
end
