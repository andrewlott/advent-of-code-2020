def solve(data)
  x = 0
  y = 0
  direction = 0 # East in polar coordinates hohoho
  data.each do |d|
    command, amount = d

    if command == "N"
      y += amount
    elsif command == "S"
      y -= amount
    elsif command == "E"
      x += amount
    elsif command == "W"
      x -= amount
    elsif command == "R"
      direction = (direction - amount) % 360
    elsif command == "L"
      direction = (direction + amount) % 360
    elsif command == "F"
      theta = direction * Math::PI / 180
      x += (amount * Math::cos(theta)).round
      y += (amount * Math::sin(theta)).round
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
