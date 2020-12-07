def solve(data)
  answers = []
  data.each.with_index do |d1, i|
    data[i+1..data.size].each.with_index do |d2, j|
      data[j+1..data.size].each.with_index do |d3, k|
        if d1 + d2 + d3 == 2020
          answers.append([d1, d2, d3])
        end
      end
    end
  end

  raise "Multiple answers found" unless answers.length == 1
  answers.first.reduce(:*)
end

# File IO
def format_lines(lines)
  lines.map { |line| line.to_i }
end

file_path = "day1_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
