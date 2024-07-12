defmodule Blackjack do
  def run do
    play_game()
  end

  defp play_game do
    {player_hand, dealer_hand} = initial_deal()
    IO.puts("Your cards: #{format_hand(player_hand)}")
    IO.puts("Dealer's cards: #{format_hand(dealer_hand)}")
    player_loop(player_hand, dealer_hand)
  end

  defp player_loop(player_hand, dealer_hand) do
    player_value = hand_value(player_hand)
    IO.puts("Your current cards value: #{player_value}")

    case player_value do
      value when value > 21 ->
        IO.puts(" You lost.")
        play_again?()
      _ ->
        action = get_action()
        case action do
          :hit ->
            new_card = deal_card()
            IO.puts("You got: #{format_card(new_card)}")
            player_loop(player_hand ++ [new_card], dealer_hand)
          :stand ->
            IO.puts("You stand.")
            dealer_loop(dealer_hand, player_hand)
        end
    end
  end

  defp dealer_loop(dealer_hand, player_hand) do
    dealer_value = hand_value(dealer_hand)

    case dealer_value do
      value when value < 17 ->
        IO.puts("Dealer hits.")
        new_card = deal_card()
        IO.puts("Dealer got: #{format_card(new_card)}")
        dealer_loop([new_card | dealer_hand], player_hand)
      _ ->
        IO.puts("Dealer stands.")
        IO.puts("Dealer's cards: #{format_hand(dealer_hand)}")
        compare_hands(dealer_hand, player_hand)
    end
  end

  defp initial_deal do
    player_hand = [deal_card(), deal_card()]
    dealer_hand = [deal_card(), deal_card()]
    {player_hand, dealer_hand}
  end

  defp deal_card do
    suits = ~w(♠ ♥ ♦ ♣)
    ranks = ~w(2 3 4 5 6 7 8 9 10 J Q K A)
    "#{Enum.random(ranks)}#{Enum.random(suits)}"
  end

  defp get_action do
    IO.write("Do you want to hit (h) or stand (s)?\n> ")
    case IO.gets("") do
      "h\n" -> :hit
      "s\n" -> :stand
      _ -> get_action()
    end
  end

  defp hand_value(hand) do
    hand
    |> Enum.map(&card_value/1)
    |> condense_aces()
  end

  defp card_value(card) do
    case String.at(card, 0) do
      "A" -> 11
      "K" -> 10
      "Q" -> 10
      "J" -> 10
      num -> String.to_integer(num)
    end
  end

  defp condense_aces(values) do
    aces = Enum.count(values, &(&1 == 11))
    total = Enum.sum(values)

    condense_aces(values, total, aces)
  end

  defp condense_aces(values, total, aces) when aces > 0 and total > 21 do
    condense_aces(values, total - 10, aces - 1)
  end

  defp condense_aces(_values, total, _aces), do: total

  defp format_hand(hand) do
    hand
    |> Enum.map(&format_card/1)
    |> Enum.join(" ")
  end

  defp format_card(card), do: card

  defp compare_hands(dealer_hand, player_hand) do
    dealer_value = hand_value(dealer_hand)
    player_value = hand_value(player_hand)

    case player_value do
      value when value > dealer_value ->
        IO.puts("You win!")
      value when value < dealer_value ->
        IO.puts("You lose!")
      _ ->
        IO.puts("It's a tie!")
    end

    play_again?()
  end

  defp play_again? do
    IO.write("Do you want to play again? (y/n)\n> ")

    case IO.gets("") do
      "y\n" -> play_game()
      "n\n" -> :ok
      _ -> play_again?()
    end
  end
end

Blackjack.run()
