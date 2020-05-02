defmodule Struct.Document do
  require Generator.Struct,
    as: StructGenerator

  StructGenerator.generate(Model.Document)
end
