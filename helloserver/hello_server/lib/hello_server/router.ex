defmodule HelloServer.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    # send_resp(conn, 200, "Hello, world!")
    {door, floor} = Elevator.status(Elevator)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(%{door: door, floor: floor}))
  end

  post "/tick" do
    {door, floor} = Elevator.tick(Elevator)
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Poison.encode!(%{door: door, floor: floor}))
  end

  post "goto/:floor" do
    Elevator.go_to(Elevator, String.to_integer(floor))
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(204, "")
  end

  match _, do: send_resp(conn, 404, "Not found.")
end
