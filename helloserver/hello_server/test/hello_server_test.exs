defmodule HelloServerTest do
  use ExUnit.Case
  doctest HelloServer

  use Plug.Test

  alias HelloServer.Router

  # test "request for / returns expected result" do
  #   conn = conn(:get, "/")
  #   # Invoke the router
  #   conn = Router.call(conn, [])
  #   assert conn.state == :sent
  #   assert conn.status == 200
  #   assert conn.resp_body ==  "{\"floor\":2,\"door\":\"closed\"}"
  # end
  #
  # test "request for /tick returns door and floor" do
  #   conn = conn(:post, "/tick")
  #   # Invoke the router
  #   conn = Router.call(conn, [])
  #   assert conn.state == :sent
  #   assert conn.status == 200
  #   assert conn.resp_body ==  "{\"floor\":1,\"door\":\"closed\"}"
  # end
  #
  # test "request for /goto/:floor returns door and :floor" do
  #   conn = conn(:post, "/goto/4")
  #   # Invoke the router
  #   conn = Router.call(conn, [])
  #   assert conn.state == :sent
  #   assert conn.status == 204
  #   assert conn.resp_body ==  ""
  # end
  #
  # test "greets the world" do
  #   assert HelloServer.hello() == :world
  # end

  describe "Router" do
    test "GET /" do # status
      conn = conn(:get, "/")

      # Invoke the router
      conn = Router.call(conn, [])

      assert conn.state == :sent
      assert conn.status == 200
      assert {:ok, status} = Poison.decode(conn.resp_body)
      assert status["floor"] == 1
      assert status["door"] == "closed"
    end

    test "POST /tick" do
      conn = conn(:post, "/tick")

      # Invoke the router
      conn = Router.call(conn, [])

      assert conn.state == :sent
      assert conn.status == 200
      assert {:ok, status} = Poison.decode(conn.resp_body)
      assert status["floor"] == 1
      assert status["door"] == "closed"
    end

    test "Entire elevator flow, tested through the router" do
      # as long nobody calls, the elevator stays on the same floor, door closed
      assert {:closed, 1} = tick_request()
      assert {:closed, 1} = tick_request()
      assert {:closed, 1} = tick_request()

      # somebody on the 4th floor calls
      :ok = goto_request(4)
      # The elevator starts moving
      assert {:closed, 2} == tick_request()
      assert {:closed, 3} = tick_request()
      assert {:closed, 4} = tick_request()
      # Doors open
      assert {:open, 4} = tick_request()
      # And close again
      assert {:closed, 4} = tick_request()

      # now it stands still again
      assert {:closed, 4} = tick_request()
      assert {:closed, 4} = tick_request()

      # tell the elevator to go to the 5th
      :ok = goto_request(5)
      assert {:closed, 5} = tick_request()
      assert {:open, 5} = tick_request() # we're there
      assert {:closed, 5} = tick_request() # door close automatically again

      # tell it to go to the 2nd, then to the 1st
      :ok = goto_request(2)
      :ok = goto_request(1)
      assert {:closed, 4} = tick_request()
      assert {:closed, 3} = tick_request()
      assert {:closed, 2} = tick_request()
      # it stops at the 2nd
      assert {:open, 2} = tick_request()
      assert {:closed, 2} = tick_request()
      assert {:closed, 1} = tick_request()
      # then at the 1st
      assert {:open, 1} = tick_request()

      # the goto order should not matter, the closest floor is served first:
      :ok = goto_request(9)
      :ok = goto_request(3)
      :ok = goto_request(5)

      assert {:closed, 1} = tick_request()
      assert {:closed, 2} = tick_request()
      assert {:closed, 3} = tick_request()
      assert {:open, 3} = tick_request()
      assert {:closed, 3} = tick_request()
      assert {:closed, 4} = tick_request()
      assert {:closed, 5} = tick_request()
      assert {:open, 5} = tick_request()
      assert {:closed, 5} = tick_request()
      assert {:closed, 6} = tick_request()
      assert {:closed, 7} = tick_request()
      assert {:closed, 8} = tick_request()
      assert {:closed, 9} = tick_request()
      assert {:open, 9} = tick_request()
    end

    defp tick_request() do
      conn = Router.call(conn(:post, "/tick"), [])
      assert conn.state == :sent
      assert conn.status == 200
      assert {:ok, status} = Poison.decode(conn.resp_body)
      {
        String.to_atom(status["door"]),
        status["floor"]
      }
    end

    defp goto_request(n) do
      conn = Router.call(conn(:post, "/goto/#{n}"), [])
      assert conn.state == :sent
      assert conn.status == 204
      :ok
    end
  end
end
