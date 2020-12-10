def solve(data)
  data = data.sort.reverse + [0]
  puts data
  jolt_differences = (1..3).map{ |i| [i, i == 3 ? 1 : 0]}.to_h
  (0...data.size - 1).each do |index|
    diff = data[index] - data[index + 1]
    jolt_differences[diff] += 1
  end
  jolt_differences[3] * jolt_differences[1]
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
