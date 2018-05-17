defmodule KeyValueStore do
  def start() do
    spawn(__MODULE__, :initialize, [])
  end

  def initialize do
    loop(%{})
  end

  def loop(store) do
    receive do
      {:get, key, sender} ->
        send(sender, store[key])
        loop(store)

      {:fetch, sender} ->
        send(sender, store)
        loop(store)

      {:put, key, value} ->
        loop(Map.put(store, key, value))

      {:delete, key} ->
        loop(Map.delete(store, key))

      {:wipe} ->
        loop(%{})
    end
  end

  def get(pid, key) do
    send(pid, {:get, key, self()})
    receive do x -> x end
  end

  def fetch(pid) do
    send(pid, {:fetch, self()})
    receive do x -> x end
  end

  def put(pid, key, value) do
    send(pid, {:put, key, value})
    :ok
  end

  def delete(pid, key) do
    send(pid, {:delete, key})
    :ok
  end

  def wipe(pid) do
    send(pid, {:wipe})
    :ok
  end
end
