defmodule StoreGenServerTest do
  use ExUnit.Case
  doctest StoreGenServer

  setup do
    {:ok, pid} = StoreGenServer.start()
    {:ok, pid: pid}
  end

  test "store", %{pid: pid} do
    assert nil == StoreGenServer.get(pid, "name")
    assert :ok == StoreGenServer.put(pid, "name", "Hein")
    assert :ok == StoreGenServer.put(pid, "name", "René")
    assert "René" == StoreGenServer.get(pid, "name")
    assert :ok == StoreGenServer.wipe(pid)
    assert nil == StoreGenServer.get(pid, "name")
  end
end
