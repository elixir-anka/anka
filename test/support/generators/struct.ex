defmodule Generator.Struct do
  @behaviour Anka.Generator

  @impl Anka.Generator
  defmacro generate(model, _opts \\ []) do
    model_expanded = Macro.expand(model, __CALLER__)

    definition =
      Anka.Model.spec(model_expanded, [:struct, :fields], default: [])
      |> Enum.map(fn
        {key, field_spec} ->
          default_value = Anka.Model.spec(field_spec, [:opts, :default])
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
