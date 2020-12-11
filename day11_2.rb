def print_data(data)
  data.each do |row|
    puts row.collect{ |v| v == nil ? "." : (v == false ? "L" : "#")}.join
  end
  puts ''
end

def set_N(data, visible_seats)
  (0...data.first.size).each do |x|
    seat = nil
    (0...data.size).each do |y|
      visible_seats[y][x]["N"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
    end
  end
end

def set_NE(data, visible_seats)
  y_min = 0
  y_max = data.size - 1
  x_min = 0
  x_max = data.first.size - 1

  (0...data.first.size).each do |diff|
    # Top half
    seat = nil
    y = 0
    x = diff
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["NE"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x -= 1
      y += 1
    end
    # Bottom half
    seat = nil
    y = data.size - 1 - diff
    x = data.first.size - 1
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["NE"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x -= 1
      y += 1
    end
  end
end

def set_E(data, visible_seats)
  (0...data.size).each do |y|
    seat = nil
    (data.first.size - 1).downto(0).each do |x|
      visible_seats[y][x]["E"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
    end
  end
end

def set_SE(data, visible_seats)
  y_min = 0
  y_max = data.size - 1
  x_min = 0
  x_max = data.first.size - 1

  (0...data.first.size).each do |diff|
    # Top half
    seat = nil
    y = diff
    x = data.first.size - 1
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["SE"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x -= 1
      y -= 1
    end
    # Bottom half
    seat = nil
    y = data.size - 1
    x = diff
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["SE"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x -= 1
      y -= 1
    end
  end
end

def set_S(data, visible_seats)
  (0...data.first.size).each do |x|
    seat = nil
    (data.size - 1).downto(0).each do |y|
      visible_seats[y][x]["S"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
    end
  end
end

def set_SW(data, visible_seats)
  y_min = 0
  y_max = data.size - 1
  x_min = 0
  x_max = data.first.size - 1

  (0...data.first.size).each do |diff|
    # Top half
    seat = nil
    y = diff
    x = 0
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["SW"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x += 1
      y -= 1
    end
    # Bottom half
    seat = nil
    y = data.size - 1
    x = data.first.size - 1 - diff
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["SW"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x += 1
      y -= 1
    end
  end
end

def set_W(data, visible_seats)
  (0...data.size).each do |y|
    seat = nil
    (0...data.first.size).each do |x|
      visible_seats[y][x]["W"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
    end
  end
end

def set_NW(data, visible_seats)
  y_min = 0
  y_max = data.size - 1
  x_min = 0
  x_max = data.first.size - 1

  (0...data.first.size).each do |diff|
    # Top half
    seat = nil
    y = 0
    x = data.first.size - 1 - diff
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["NW"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x += 1
      y += 1
    end
    # Bottom half
    seat = nil
    y = data.size - 1 - diff
    x = 0
    while y.between?(y_min, y_max) and x.between?(x_min, x_max)
      visible_seats[y][x]["NW"] = seat
      if data[y][x] != nil
        seat = data[y][x]
      end
      x += 1
      y += 1
    end
  end
end

def calculate_visible_seats(data)
  visible_seats = data.collect{ |row| row.collect{ |s| {"N" => nil, "NE" => nil, "E" => nil, "SE" => nil, "S" => nil, "SW" => nil, "W" => nil, "NW" => nil }}}
  set_N(data, visible_seats)
  set_NE(data, visible_seats)
  set_E(data, visible_seats)
  set_SE(data, visible_seats)
  set_S(data, visible_seats)
  set_SW(data, visible_seats)
  set_W(data, visible_seats)
  set_NW(data, visible_seats)
  visible_seats.collect{ |row| row.collect{ |s| s.values.count(true)}}
end

def solve(data)
  prev_state = nil
  while prev_state != data
    prev_state = data.collect{ |row| row.clone }
    visible_seats = calculate_visible_seats(data)
    (0...data.size).each do |y|
      (0...data.first.size).each do |x|
        occupied = prev_state[y][x]
        if occupied == nil
          # Floor
          next
        end

        if occupied and visible_seats[y][x] >= 5
          data[y][x] = false
        elsif not occupied and visible_seats[y][x] == 0
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
