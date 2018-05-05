defmodule Anka.Test do

	use ExUnit.Case,
		async: true

	doctest Anka
	doctest Anka.Generator
	doctest Anka.Model
	doctest Anka.Model.Interpreter

end
