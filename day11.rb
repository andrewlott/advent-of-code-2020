def print_data(data)
  data.each do |row|
    puts row.collect{ |v| v == nil ? "." : (v == false ? "L" : "#")}.join
  end
  puts ''
end

def get_neighbors(data, x, y, num = 1)
  top = [y - num, 0].max
  bottom = [y + num, data.size - 1].min
  left = [x - num, 0].max
  right = [x + num, data.first.size - 1].min
  neighbors = []
  (top..bottom).each do |y_index|
    (left..right).each do |x_index|
      if x_index == x and y_index == y
        # Omit my seat
        next
      end
      neighbors.append(data[y_index][x_index])
    end
  end
  neighbors
end

def solve(data)
  prev_state = nil
  while prev_state != data
    prev_state = data.collect{ |row| row.clone }
    (0...data.size).each do |y|
      (0...data.first.size).each do |x|
        occupied = prev_state[y][x]
        if occupied == nil
          # Floor
          next
        end
        neighbors = get_neighbors(prev_state, x, y)
        if occupied and neighbors.count(true) >= 4
          data[y][x] = false
        elsif not occupied and neighbors.count(true) == 0
          data[y][x] = true
        end
      end
    end
    #print_data(data)
  end
  data.flatten.count(true)
end

# File IO
def format_lines(lines)
  data = []
  lines.each do |line|
    row = line.strip.split("").collect{ |v| v == "." ? nil : (v == "L" ? false : true)}
    data.append(row)
  end
  data
end

file_path = "day11_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
