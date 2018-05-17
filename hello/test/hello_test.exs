defmodule HelloTest do
  use ExUnit.Case
  doctest Hello

  test "greets the world" do
    assert Hello.hello() == :world
  end

  test "greets the world again" do
    assert "Hello Lolo" == Hello.greet()
  end

  test "greets the world with a name" do
    assert "Hello Frank" == Hello.greet_name("Frank")
  end
end
