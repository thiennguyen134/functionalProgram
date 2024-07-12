

# Part 3
IO.puts "Enter a line of text:"
text = IO.read(:line)
char_count = String.length(text)
IO.puts "Number of characters in the text: #{char_count}"
reversed_text = String.reverse(text)
IO.puts "Reversed text: #{reversed_text}"
replaced_text = String.replace(text, "foo", "bar")
IO.puts "Text with 'foo' replaced by 'bar': #{replaced_text}"
