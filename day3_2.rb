def solve(data)
  increments = [
    #y, x
    [1, 1],
    [1, 3],
    [1, 5],
    [1, 7],
    [2, 1],
  ]
  sums = []
  increments.each do |y_inc, x_inc|
    sum = 0
    (0...data.size).step(y_inc) do |y|
      row = data[y]
      x = (y / y_inc) * x_inc
      sum += row[x % row.size]
    end
    sums.append sum
  end
  sums.reduce(:*)
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
