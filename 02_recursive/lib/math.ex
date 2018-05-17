defmodule Math do
  @doc """
  Calculate fibonacci (which is the sum of previous 2 fibonaccis)

  fib(0) -> 1
  fib(1) -> 1
  fib(n) -> fib(n-2) + fib(n-1)
  0 1 2 3 4 5  6  7
  1 1 2 3 5 8 11 19
  """
  @spec fibonacci(integer) :: integer
  def fibonacci(n) when n == 0 or n ==1, do: 1
  def fibonacci(n), do: fibonacci(n-1) + fibonacci(n-2)

  @doc """
  sum/1 takes a list of numbers, runs it through a recursive function
  """
  def sum([]), do: 0
  def sum([n]), do: n
  def sum([h | [g | t]), do: h + sum(t)
end
