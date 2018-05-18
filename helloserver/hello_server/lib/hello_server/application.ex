defmodule HelloServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: HelloServer.Worker.start_link(arg)
      # {HelloServer.Worker, arg},
      Supervisor.Spec.worker(Elevator, [25]),
      Plug.Adapters.Cowboy.child_spec(:http, HelloServer.Router, [], port: 8080)
    ]

    IO.puts "Started the application!"
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
