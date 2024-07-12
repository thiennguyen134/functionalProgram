defmodule Main do
  import Calculator

  def run do
    loop()
  end

  defp loop do
    IO.puts("Enter an expression (e.g., 123+456) or type 'exit' to quit:")
    input = IO.gets("> ")

    case input do
      "exit\n" ->
        IO.puts("Goodbye!")
        :ok

      expression ->
        case calc(String.trim(expression)) do
          {:error, reason} ->
            IO.puts("Error: #{reason}")
            loop()

          result ->
            IO.puts("Result: #{result}")
            loop()
        end
    end
  end
end
