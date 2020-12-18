def solve_expression(expression)
  values = expression.scan(/\d+/).collect{ |v| v.to_i}
  operators = expression.scan(/[\+\*]/)
  val = values.first
  (0...operators.size).each do |i|
    operator = operators[i]
    r = values[i + 1]
    if operator == "*"
      val *= r
    else
      val += r
    end
  end
  return val
end

def solve(data)
  sum = 0
  data.each do |expression|
    while not (/^[\d\s\+\*]+?$/).match?(expression)
      parens = expression.scan(/\([\d\s\+\*]+?\)/)
      parens.each do |p|
        expression.sub!(p, solve_expression(p[1...p.size - 1]).to_s)
      end
    end
    sum += solve_expression(expression)
  end
  return sum
end

# File IO
def format_lines(lines)
  lines
end

file_path = "day18_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
