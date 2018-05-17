defmodule FizzBuzz do
  import Kernel, except: [if: 2, unless: 2]

  @doc """
  FizzBuzz translates numbers(from 1 to 100) into
  "buzz" if it's a multiple of 3
  "fizz" if it's a multiple of 5
  "fizzbuzz" if it's a multiple of 3 and 5
  the number itself if it doesn't match the above

  ## Examples

    iex>FizzBuzz.translate(1)
    1
    iex>FizzBuzz.translate(5)
    "fizz"
    iex>FizzBuzz.translate(3)
    "buzz"
    iex>FizzBuzz.translate(45)
    "fizzbuzz"

  """

  @spec translate(number) :: String.t | number
  # Solution example 1
  def translate(number) do
    match(rem(number, 3), rem(number, 5), number)
  end

  def match(0, 0, _), do: "fizzbuzz"
  def match(_, 0, _), do: "fizz"
  def match(0, _, _), do: "buzz"
  def match(_, _, n), do: n

  # Solution example 2
  # def translate(n) when rem(n,3)==0 and rem(n,5)==0 do
  #   "fizzbuzz"
  # end
  # def translate(n) when rem(n,3)==0 do
  #   "buzz"
  # end
  # def translate(n) when rem(n,5)==0 do
  #   "fizz"
  # end
  # def translate(n) do
  #   n
  # end
end

for n <- 1..100 do
  IO.puts FizzBuzz.translate(n)
end