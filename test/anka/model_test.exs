defmodule Anka.Model.Test do
  use ExUnit.Case,
    async: true

  doctest Anka.Model,
    async: true

  test "spec/0 returns the given opts to __using__/1" do
    assert Model.Document.spec() == Spec.document()
  end

  test "spec/1 returns partial definition under a path" do
    assert Model.Document.spec([:name, :singular]) == :document
    assert Model.Document.spec([:name, :plural]) == :documents
    assert Model.Document.spec([:struct, :fields, Access.at(0)]) == :id
    assert Model.Document.spec([:struct, :fields, :content]) == [opts: [default: ""]]
    assert Model.Document.spec([:struct, :fields, Access.at(3)]) == nil
  end

  test "spec/2 returns partial definition under a path, respects default opt" do
    assert Model.Document.spec(:extra, default: []) == []
  end
end
