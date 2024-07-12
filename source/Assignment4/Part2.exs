combined = fn
  a ->
    if is_binary(a) do
      fn
        b ->
          if is_binary(b) do
            "#{a}#{b}"
          else
            a <> to_string(b)
          end
      end
    else
      unless is_number(a) do
        fn
          _ -> nil
        end
      else
        fn
          b ->
            if is_binary(b) do
              to_string(a) <> b
            else
              a + b
            end
        end
      end
    end
end

IO.puts(combined.("This is Part 2 of ").("Assignment 3!")) # Output: This is Part 2 of Assignment 3!
IO.puts(combined.(101).(" dogs")) # Output: 101 dogs
IO.puts(combined.(3).(9)) # Output: 12
IO.puts(combined.("The answer is: ").(27)) # Output: The answer is: 27
