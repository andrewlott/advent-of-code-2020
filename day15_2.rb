def solve(data)
  total_turns = 30000000
  # Map of number to last index
  turns_hash = {}
  data[0...data.size - 1].each_with_index do |d, index|
    # Don't include the last one
    turns_hash[d] = index
  end

  last_spoken_number = data.last
  spoken_number = data.last
  turn = data.size - 1
  while turn < total_turns
    last_spoken_number = spoken_number

    if turns_hash.key?(last_spoken_number)
      spoken_number = turn - turns_hash[last_spoken_number]
    else
      # Number has not been said before
      spoken_number = 0
    end

    turns_hash[last_spoken_number] = turn
    turn += 1
  end
  last_spoken_number
end

# File IO
def format_lines(lines)
  lines.first.split(",").collect{ |n| n.to_i}
end

file_path = "day15_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
