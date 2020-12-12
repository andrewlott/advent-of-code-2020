def quadrant_adjustment(x, y)
  if x < 0
    return Math::PI
  elsif y < 0
    return Math::PI * 2
  end
  return 0
end

def deg2rad(deg)
  return deg * Math::PI / 180
end

def cartesian_to_polar(x, y)
  r = Math::sqrt(x.pow(2) + y.pow(2))
  if r == 0.0
    # Don't NaN
    return [0.0, 0.0]
  end
  theta = Math::atan(y.to_f / x.to_f) + quadrant_adjustment(x, y)
  return [r, theta]
end

def polar_to_cartesian(r, theta)
  x = (r * Math::cos(theta)).round
  y = (r * Math::sin(theta)).round
  return [x, y]
end

def solve(data)
  # Waypoint relative position
  w_x = 10
  w_y = 1
  # Ship position
  x = 0
  y = 0
  data.each do |d|
    command, amount = d

    if command == "N"
      w_y += amount
    elsif command == "S"
      w_y -= amount
    elsif command == "E"
      w_x += amount
    elsif command == "W"
      w_x -= amount
    elsif command == "L"
      r, theta = cartesian_to_polar(w_x, w_y)
      theta += deg2rad(amount)
      w_x, w_y = polar_to_cartesian(r, theta)
    elsif command == "R"
      r, theta = cartesian_to_polar(w_x, w_y)
      theta -= deg2rad(amount)
      w_x, w_y = polar_to_cartesian(r, theta)
    elsif command == "F"
      x += w_x * amount
      y += w_y * amount
    else
      raise "Unknown command"
    end
  end
  x.abs + y.abs
end

# File IO
def format_lines(lines)
  data = []
  lines.each do |line|
    command = line.scan(/\D+/).first
    amount = line.scan(/\d+/).first
    data.append([command, amount.to_i])
  end
  data
end

file_path = "day12_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
