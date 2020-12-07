def solve(data)
  groups = []
  data.each do |d|
    all_answers = d.join
    answers = {}
    all_answers.each_char do |a|
      if not answers.key?(a)
        answers[a] = all_answers.scan(/#{a}/).size
      end
    end
    groups.append(answers.select{ |key, value| value == d.size}.size)
  end
  groups.sum
end

# File IO
def format_lines(lines)
  groups = [[]]
  lines.each do |l|
    l = l.strip
    if l.size == 0
      groups.append([])
      next
    end
    groups.last.append(l)
  end
  groups
end

file_path = "day6_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
