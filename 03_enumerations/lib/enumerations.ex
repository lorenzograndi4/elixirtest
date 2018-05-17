defmodule Enumerations do

  @doc """
  adds N to each element of the given list

      iex> Enumerations.add_n([1, 2, 3], 3)
      [4, 5, 6]
      iex> Enumerations.add_n([1], -1)
      [0]
  """
  def add_n(list, n) do
    Enum.map(list, fn(i) -> i+n end)
  end


  @doc """
  counts the number of dots in a string.

      iex> Enumerations.count_dots("Hello.")
      1
      iex> Enumerations.count_dots("This is a test... How long this will work.")
      4
  """
  def count_dots(str) do
    str |> String.codepoints |> Enum.count(&dot?/1)
  end

  def dot?("."), do: true
  def dot?(_), do: false

  @doc """
  takes a string and returns a map with the word frequency.

      iex> Enumerations.freq("hello world this is world")
      %{"hello" => 1, "world" => 2, "this" => 1, "is" => 1}
  """
  def freq(str) do
    str
    |> String.split
    |> Enum.reduce(%{}, &counter/2)
  end

  def counter(word,  words) do
    Map.update(words, word, 1, &(&1 + 1))
  end
end
