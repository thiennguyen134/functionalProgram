defmodule ChatServer do
  require Logger

  def start(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info("Server started on port #{port}")
    loop_accept(socket, %{})
  end

  defp loop_accept(socket, clients) do
    {:ok, client_socket} = :gen_tcp.accept(socket)
    {:ok, client_pid} = Task.start(fn -> handle_client(client_socket, clients) end)
    :ok = :gen_tcp.controlling_process(client_socket, client_pid)
    loop_accept(socket, Map.put(clients, client_pid, client_socket))
  end

  defp handle_client(socket, clients) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        name = String.trim(data)
        Logger.info("#{name} joined")
        broadcast(clients, "#{name} joined\n")
        loop_receive(name, socket, clients)
      {:error, _} ->
        :ok
    end
  end

  defp loop_receive(name, socket, clients) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        message = String.trim(data)
        if message == "shutdown" do
          Logger.info("Shutting down server...")
          broadcast(clients, "Server shutting down...\n")
          :ok
        else
          Logger.info("#{name}: #{message}")
          broadcast(clients, "#{name}: #{message}\n")
          loop_receive(name, socket, clients)
        end
      {:error, _} ->
        Logger.info("#{name} left")
        broadcast(clients, "#{name} left\n")
        :ok
    end
  end

  defp broadcast(clients, message) do
    for {_pid, client_socket} <- clients do
      :gen_tcp.send(client_socket, message)
    end
  end
end

ChatServer.start(8080)
