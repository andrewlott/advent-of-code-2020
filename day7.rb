def solve(data)
  my_bag = "shiny gold bag"
  queue = [my_bag]
  count = 0
  index = 0
  while index < queue.size
    b = queue[index]
    containers = data[b]
    containers&.each do |d|
      if not queue.include?(d)
        queue.append(d)
        count += 1
      end
    end
    index += 1
  end
  count
end

# File IO
def format_lines(lines)
  data = {}
  lines.each do |l|
    first, last= l.split("contain").collect{ |v| v.strip()}
    outer_bag = (/^([\w+\s]+bag)/).match(first).captures.first
    inner_bags = last.scan(/\d+\s([\w+\s]+bag)/).collect{ |v| v.first}
    inner_bags.each do |b|
      if not data.include?(b)
        data[b] = []
      end
      data[b].append(outer_bag)
    end
  end
  data
end

file_path = "day7_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
