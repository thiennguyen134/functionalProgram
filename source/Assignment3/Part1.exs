n = IO.gets("Enter a number: ") |> String.trim() |> String.to_integer()

divisible_by_3 = rem(n, 3) == 0
divisible_by_5 = rem(n, 5) == 0
divisible_by_7 = rem(n, 7) == 0

if divisible_by_3 do
  IO.puts("Divisible by 3")
end

if divisible_by_5 do
  IO.puts("Divisible by 5")
end

if divisible_by_7 do
  IO.puts("Divisible by 7")
end

smallest_divisible = Enum.find((2..n), &(rem(n, &1) == 0))

unless divisible_by_3 or divisible_by_5 or divisible_by_7 do
  IO.puts("Smallest divisible: #{smallest_divisible}")
end
