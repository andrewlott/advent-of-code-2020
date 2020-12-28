def solve(decks)
  total_cards = decks.flatten.size
  while not decks.any?{ |deck| deck.size == total_cards }
    top_decks = decks.collect{ |deck| deck.shift }
    winning_card = top_decks.max
    winner_index = top_decks.index(winning_card)
    decks[winner_index] += [winning_card] + (top_decks - [winning_card])
  end
  winning_deck = decks.select{ |deck| deck.size == total_cards }.first
  return winning_deck.collect{ |card| card * (winning_deck.size - winning_deck.index(card))}.sum
end

# File IO
def format_lines(lines)
  data = []
  lines.each do |line|
    if line.strip.size == 0
      next
    elsif /^Player \d+:$/.match?(line)
      data.append([])
    else
      data.last.append(line.strip.to_i)
    end
  end
  return data
end

file_path = "day22_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
