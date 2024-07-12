defmodule Calculator do
  def calc(expression) do
    {n1, rest} = Float.parse(expression)
    {op, rest} = parse_operator(rest)
    {n2, _} = Float.parse(rest)

    case op do
      "+" -> Math.add(n1, n2)
      "-" -> Math.sub(n1, n2)
      "*" -> Math.mul(n1, n2)
      "/" -> Math.div(n1, n2)
      _ -> {:error, "Invalid operator"}
    end
  end

  defp parse_operator(<<op, rest::binary>>) when op in [?+, ?-, ?*, ?/] do
    {<<op>>, rest}
  end
end
