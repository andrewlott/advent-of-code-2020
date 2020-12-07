def solve(data)
  puts data.collect{|v| v.join(' ')}
  valid_pass = data.select{ |lower, upper, character, pass| pass.count(character).between?(lower, upper) }
  valid_pass.size
end

# File IO
def format_lines(lines)
  data = []
  lines.map do |line|
    reqs, pass = line.split(':').collect(&:strip)
    range, character = reqs.split(' ').collect(&:strip)
    lower, upper = range.split('-').collect(&:strip).collect(&:to_i)
    data.append([lower, upper, character, pass])
  end
  data
end

file_path = "day2_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
