def solve(data)
  invalid_number = 400480901
  lower_index = 0
  upper_index = 1
  while true
    slice = data[lower_index..upper_index]
    sum = slice.sum
    if sum < invalid_number
      upper_index = [data.size - 1, upper_index + 1].min
    elsif sum > invalid_number
      lower_index += 1
      upper_index = [lower_index + 1, upper_index].max
    else
      return slice.min + slice.max
    end
  end
end

# File IO
def format_lines(lines)
  lines.collect{ |l| l.to_i}
end

file_path = "day9_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
