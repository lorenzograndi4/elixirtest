defmodule KeyValueStoreTest do
  use ExUnit.Case
  doctest KeyValueStore

  setup do
    pid = KeyValueStore.start()
    {:ok, pid: pid}
  end

  test "store and retrieve value", %{pid: pid} do
    assert nil == KeyValueStore.get(pid, "name")
    assert :ok == KeyValueStore.put(pid, "name0", "João")
    assert :ok == KeyValueStore.put(pid, "name1", "Mario")
    assert :ok == KeyValueStore.put(pid, "name2", "GIGI")
    assert :ok == KeyValueStore.put(pid, "name3", "Ali")
    assert %{"name0" => "João", "name1" => "Mario", "name2" => "GIGI", "name3" => "Ali"} == KeyValueStore.fetch(pid)
    assert "Ali" == KeyValueStore.get(pid, "name3")
  end

  test "store and delete value", %{pid: pid} do
    assert nil == KeyValueStore.get(pid, "name")
    assert :ok == KeyValueStore.put(pid, "name", "Joost")
    assert "Joost" == KeyValueStore.get(pid, "name")
    assert :ok == KeyValueStore.delete(pid, "name")
    assert nil == KeyValueStore.get(pid, "name")
  end

  test "store and wipe all", %{pid: pid} do
    assert nil == KeyValueStore.get(pid, "name")
    assert :ok == KeyValueStore.put(pid, "name", "Luc")
    assert "Luc" == KeyValueStore.get(pid, "name")
    assert :ok == KeyValueStore.wipe(pid)
    assert nil == KeyValueStore.get(pid, "name")
  end
end
