defmodule MathTest do
  use ExUnit.Case
  doctest Math

  test "first fibonacci" do
    assert Math.fibonacci(0) == 1
    assert Math.fibonacci(1) == 1
  end

  test "random fibonaccis" do
    assert Math.fibonacci(2) == 2
    assert Math.fibonacci(3) == 3
    assert Math.fibonacci(4) == 5
    assert Math.fibonacci(5) == 8
    assert Math.fibonacci(25) == 121393
    assert Math.fibonacci(17) == 2584
    assert Math.fibonacci(13) == 377
  end

  # Sum tests

  test "sum of empty list is 0" do
    assert Math.sum([]) == 0
  end

  test "random sums" do
    assert Math.sum([1, 3]) == 4
    assert Math.sum([1, 2, 3]) == 6
    assert Math.sum([1, 3, 5]) == 9
    assert Math.sum([3, 3]) == 6
    assert_raise(ArithmeticError, fn ->
      Math.sum([1, "test", 3])
    end)
    assert Math.sum([1, 2, 3, 4, 0x1F, 3,54,32,3]) == 133
  end
end
