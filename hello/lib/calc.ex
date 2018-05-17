defmodule Calc do
  def square(n) do
    n*n
  end

  def short_square(n) do n*n end

  def multiplier(n) do fn (n) -> (n*n) end end
end