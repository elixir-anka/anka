defmodule Struct.User do
  require Generator.Struct,
    as: StructGenerator

  StructGenerator.generate(Model.User)
end
