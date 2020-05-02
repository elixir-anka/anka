defmodule Anka.Generator.Test do
  use ExUnit.Case,
    async: true

  doctest Anka.Generator,
    async: true

  test "Generator.Struct derives struct" do
    field_names =
      Model.Document.spec([:struct, :fields])
      |> Enum.map(fn
        {key, _any} ->
          key

        key ->
          key
      end)
      |> Enum.sort()

    struct_keys =
      %Struct.Document{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.sort()

    assert field_names == struct_keys
  end

  test "Generator.Struct respects default values" do
    default_value =
      Model.Document.spec([
        :struct,
        :fields,
        :content,
        :opts,
        :default
      ])

    document = %Struct.Document{}
    assert document.content == default_value
  end
end
