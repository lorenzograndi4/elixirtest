defmodule StoreGenServer do
  use GenServer

  ## Client API
  def start() do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def get(server, key) do
    GenServer.call(server, {:get, key})
  end

  def put(server, key, value) do
    GenServer.cast(server, {:put, key, value})
  end

  def wipe(server) do
    GenServer.cast(server, {:wipe})
  end

  ## Server Callbacks
  def init(_args) do
    {:ok, %{}} # The initial state
  end

  def handle_cast({:wipe}, _state) do
    {:noreply, %{}} # Return a new empty Map
  end

  def handle_cast({:put, key, value}, state) do
  # @callback handle_cast(request :: term, state :: term) :: {:noreply, new_state}
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    # @callback handle_call(request :: any, from, state :: any) :: {:reply, reply, new_state}
    {:reply, Map.get(state, key), state}
  end
end
