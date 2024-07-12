defmodule PigLatin do
  @vowels ~w(a e i o u)

  @consonant_clusters ["ch", "qu", "squ", "th", "thr", "sch"]

  def translate_word(word) when String.match?(word, ~r/\A(xr|yt|[aeiou])/i) do
    word <> "ay"
  end

  def translate_word(word) when String.match?(word, ~r/\A([bcdfghjklmnpqrstvwxyz]|[bcdfghjklmnpqrstvwxyz](?:(?:(?:qu|ch)?)?thr|sch|squ)?)[a-z]*/i) do
    [first_char | rest] = word
    rest = String.downcase(rest)  # convert the rest to lowercase
    first_char = String.downcase(first_char)  # convert the first character to lowercase
    case Enum.find(@consonant_clusters, &String.starts_with?(rest, &1)) do
      nil ->
        rest <> first_char <> "ay"
      _ ->
        [cluster | _rest] = Enum.find(@consonant_clusters, &String.starts_with?(rest, &1))
        cluster <> rest <> first_char <> "ay"
    end
  end

  def translate_word(word), do: word

  def translate_sentence(sentence) do
    sentence
    |> String.trim()
    |> String.split(~r/[., ]+/, trim: true)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end
end



IO.puts PigLatin.translate_sentence("Pattern Matching with Elixir. Remember that equals sign is a match operator, not an assignment.")
