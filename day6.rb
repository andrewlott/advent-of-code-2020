def solve(data)
  data.collect{ |d| d.keys.size}.sum
end

# File IO
def format_lines(lines)
  groups = [{}]
  lines.each do |l|
    l = l.strip
    if l.size == 0
      groups.append({})
      next
    end
    l.each_char do |c|
      if groups.last.key?(c)
        next
      end
      groups.last[c] = 1
    end
  end
  groups
end

file_path = "day6_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
