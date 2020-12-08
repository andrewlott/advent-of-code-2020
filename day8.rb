def solve(data)
  acc = 0
  index = 0
  visited_indices = {}
  while not visited_indices.key?(index)
    visited_indices[index] = 1

    operation, value = data[index]
    if operation == "acc"
      acc += value
      index += 1
    elsif operation == "jmp"
      index += value
    elsif operation == "nop"
      index += 1
    else
      raise "Unknown operation #{operation}"
    end
  end
  acc
end

# File IO
def format_lines(lines)
  data = []
  lines.each do |l|
    operation, value = /^(\w+) ([+-]\d+)$/.match(l).captures
    data.append([operation, value.to_i])
  end
  data
end

file_path = "day8_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
