defmodule Anka.Generator.Test do
  use ExUnit.Case,
    async: true

  test "generates struct" do
    fields = Model.User.spec([:struct, :fields])
    user = %Struct.User{}
    user_as_map = Map.from_struct(user)
    map_keys = Map.keys(user_as_map)
    assert fields == map_keys
  end
end
