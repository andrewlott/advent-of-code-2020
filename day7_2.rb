$solved = {}

def solve_rec(data, bag)
  if $solved.key?(bag)
    return $solved[bag]
  end
  $solved[bag] = data[bag].collect{ |b, count| count.to_i * (solve_rec(data, b) + 1)}.sum
end

def solve(data)
  my_bag = "shiny gold bag"
  solve_rec(data, my_bag)
end

# File IO
def format_lines(lines)
  data = {}
  lines.each do |l|
    first, last= l.split("contain").collect{ |v| v.strip()}
    outer_bag = (/^([\w+\s]+bag)/).match(first).captures.first
    inner_bags = last.scan(/(\d+)\s([\w+\s]+bag)/).collect{ |v| [v.last, v.first]}.flatten
    inner_bags = Hash[*inner_bags]
    data[outer_bag] = inner_bags
  end
  data
end

file_path = "day7_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
