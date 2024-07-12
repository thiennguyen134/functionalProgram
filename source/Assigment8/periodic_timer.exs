defmodule PeriodicTimer do
  use GenServer



  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def start_timer(period, fun) do
    GenServer.cast(__MODULE__, {:start_timer, period, fun})
  end

  def stop_timer() do
    GenServer.call(__MODULE__, :stop_timer)
  end



  def init(_opts) do
    {:ok, nil}
  end

  def handle_cast({:start_timer, period, fun}, _state) do
    timer_ref = Process.send_after(self(), :trigger, period)
    {:noreply, {timer_ref, period, fun}}
  end

  def handle_info(:trigger, {timer_ref, period, fun}) do
    result = fun.()
    new_state = handle_result(result, timer_ref, period, fun)
    {:noreply, new_state}
  end

  def handle_call(:stop_timer, _from, state) do
    case state do
      nil ->
        {:reply, :ok, nil}
      {timer_ref, _period, _fun} ->
        Process.cancel_timer(timer_ref)
        {:reply, :ok, nil}
    end
  end



  defp handle_result(:cancel, timer_ref, _period, _fun) do
    Process.cancel_timer(timer_ref)
    nil
  end

  defp handle_result(:ok, _timer_ref, period, fun) do
    new_timer_ref = Process.send_after(self(), :trigger, period)
    {new_timer_ref, period, fun}
  end
end


{:ok, _pid} = PeriodicTimer.start_link([])

timer_function = fn ->
  IO.puts("Hello world")
  :ok
end
PeriodicTimer.start_timer(1_000, timer_function)


Process.sleep(5_000)
PeriodicTimer.stop_timer()
