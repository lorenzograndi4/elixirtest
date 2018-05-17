defmodule Hello do
  @moduledoc """
  Documentation for Hello.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hello.hello
      :world

  """
  def hello do
    :world
  end

  def greet do
    name = "Lolo"
    "Hello " <> name
  end

  def greet_name(name) do
    "Hello " <> name
  end
end
