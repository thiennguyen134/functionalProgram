defmodule Math do
  def add(x, y) do
    info("Adding", x, y)
    x + y
  end

  def sub(x, y) do
    info("Subtracting", x, y)
    x - y
  end

  def mul(x, y) do
    info("Multiplying", x, y)
    x * y
  end

  def div(x, y) do
    info("Dividing", x, y)
    x / y
  end

  defp info(operation, x, y) do
    IO.puts("#{operation} #{x} and #{y}")
  end
end
