def solve(data)
  total_turns = 2020
  spoken_number = data.last
  turns = data[0...data.size]
  while turns.size < total_turns
    last_number = turns.last
    num_occurrences = turns.count(last_number)

    if num_occurrences == 1
      spoken_number = 0
    else
      spoken_number = turns[0...turns.size - 1].reverse().index(last_number) + 1
    end
    turns += [spoken_number]
  end
  spoken_number
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
