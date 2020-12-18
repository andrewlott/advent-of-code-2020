def solve_expression(expression)
  add_regex = /\d+\s\+\s\d+/
  mul_regex = /\d+\s\*\s\d+/
  while not (/^\d+$/).match?(expression)
    addition = expression.scan(add_regex).first
    while addition != nil
      l, r = addition.scan(/\d+/).collect{ |v| v.to_i}
      expression.sub!(addition, (l + r).to_s)
      addition = expression.scan(add_regex).first
    end

    multiplication = expression.scan(mul_regex).first
    while multiplication != nil
      l, r = multiplication.scan(/\d+/).collect{ |v| v.to_i}
      expression.sub!(multiplication, (l * r).to_s)
      multiplication = expression.scan(mul_regex).first
    end
  end
  return expression.to_i
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
