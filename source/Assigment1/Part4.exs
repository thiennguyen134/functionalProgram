#Part 1
product = fn (a,b,c) -> a * b * c end

#Part 2
{a, _} = IO.gets("Enter the first number: ") |> Integer.parse
{b, _} = IO.gets("Enter the second number: ") |> Integer.parse
{c, _} = IO.gets("Enter the third number: ") |> Integer.parse
result = product.(a,b,c)

#Part 3
IO.puts("Result: #{result}")

#Part 4
concat_lists = fn(list1, list2) -> list1 ++ list2 end

#Part 5


list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = concat_lists.(list1, list2)
IO.puts("Result: #{inspect result}")

#Part 6
status = {:ok, :fail}

#Part 7

status = Tuple.insert_at(status, 1, :cancelled)
IO.puts("Combined tuple: #{inspect status}")
