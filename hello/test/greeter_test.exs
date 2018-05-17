defmodule GreeterTest do
  use ExUnit.Case
  doctest Greeter

  test "greets the world with a name" do
    assert "Hello, Arjan" == Greeter.greet("Arjan")
  end
  test "greets without name" do
    assert "Hello, stranger" == Greeter.greet()
  end
end
