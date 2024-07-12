defmodule StepCounter do
  def count_steps(current_step, target_step) when current_step <= target_step do
    IO.puts("Step #{current_step}")
    count_steps(current_step + 1, target_step)
  end

  def count_steps(_current_step, _target_step), do: nil
end

StepCounter.count_steps(1, 5)
