defmodule Anka.Model.Test do
  use ExUnit.Case,
    async: true

  doctest Anka.Model,
    async: true

  test "gets model spec" do
    assert Model.User.spec() == Spec.User.spec()
  end

  test "gets model spec by keys" do
    assert Model.User.spec([:name, :singular]) == :user
    assert Model.User.spec([:name, :plural]) == :users
    assert Model.User.spec([:struct, :fields, Access.at(0)]) == :id
    assert Model.User.spec([:struct, :fields, Access.at(1)]) == :username
    assert Model.User.spec([:struct, :fields, Access.at(3)]) == nil
  end

  test "gets model spec by keys or default" do
    assert Model.User.spec(:extra, default: []) == []
  end
end
