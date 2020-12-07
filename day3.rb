def solve(data)
  x_inc = 3
  y_inc = 1
  sum = 0
  (0...data.size).step(y_inc) do |y|
    row = data[y]
    sum += row[(x_inc * y) % row.size]
  end
  sum
end

# File IO
def format_lines(lines)
  data = lines.collect{ |line| line.strip.split("").collect { |c| c == '.' ? 0 : 1} }
  data
end

file_path = "day3_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
