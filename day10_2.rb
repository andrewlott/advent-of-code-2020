def solve_rec(data, solved)
  if solved.key?(data.first)
    return solved[data.first]
  end
  slices = (1..3).select{ |i| i < data.size and data.first - 3 <= data[i]}.collect{ |i| data[i..data.size]}
  solved[data.first] = slices.collect{ |slice| solve_rec(slice, solved) }.sum
end

def solve(data)
  data = [data.max + 3] + data.sort.reverse + [0]
  solved = {0 => 1}
  solve_rec(data, solved)
end

# File IO
def format_lines(lines)
  lines.collect{ |l| l.to_i}
end

file_path = "day10_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
