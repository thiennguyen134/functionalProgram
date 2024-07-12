string = "99 bottles of beer on the wall"
word_list = String.split(string, " ")
word_count = Enum.count(word_list)
IO.puts("The number of words in the string is #{word_count}")
