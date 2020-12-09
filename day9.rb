def solve(data)
  preamble_length = 25
  (preamble_length...data.size).each do |index|
    target_number = data[index]
    h = (index-preamble_length...index).map{ |i| [data[i], 1]}.to_h
    valid = h.select{ |k| h.key?(target_number - k)}
    if valid.size == 0
      return data[index]
    end
  end
  nil
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
