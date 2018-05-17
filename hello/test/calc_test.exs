defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "calculates the square" do
    assert 144 == Calc.square(12)
  end

  test "shortly calculates the square" do
    assert 64 == Calc.short_square(8)
  end

  test "calculates double with a function" do
    double = Calc.multiplier(2)
    assert 4 == double.(2)
  end

  test "calculates triple with a function" do
    triple = Calc.multiplier(3)
    assert 9 == triple.(3)
  end
end
