def solve(data)
  puts data.collect{|v| v.join(' ')}
  valid_pass = data.select{ |idx1, idx2, character, pass| (pass[idx1 - 1] == character) ^ (pass[idx2 - 1] == character) }
  valid_pass.size
end

# File IO
def format_lines(lines)
  data = []
  lines.map do |line|
    reqs, pass = line.split(':').collect(&:strip)
    range, character = reqs.split(' ').collect(&:strip)
    idx1, idx2 = range.split('-').collect(&:strip).collect(&:to_i)
    data.append([idx1, idx2, character, pass])
  end
  data
end

file_path = "day2_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
