defmodule ChatClient do
  require Logger

  def start(host, port) do
    {:ok, socket} = :gen_tcp.connect(host, port, [:binary, packet: :line, active: false])
    {:ok, _} = Task.start(fn -> loop_receive(socket) end)
    {:ok, socket}
  end

  defp loop_receive(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        IO.write(data)
        loop_receive(socket)
      {:error, _} ->
        Logger.info("Disconnected from server")
        :ok
    end
  end

  def send_message_loop(socket) do
    message = IO.gets("> ")
    case message do
      "exit\n" ->
        :gen_tcp.close(socket)
        Logger.info("Exiting...")
      _ ->
        :gen_tcp.send(socket, message)
        send_message_loop(socket)
    end
  end
end

{:ok, socket} = ChatClient.start('localhost', 8080)

IO.write("Enter your name: ")
name = IO.gets("")
:gen_tcp.send(socket, name)

ChatClient.send_message_loop(socket)
