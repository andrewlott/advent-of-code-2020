def solve(data)
  tiles = {}

  direction_map = {
    "e" => [1.0, 0.0],
    "se" => [0.5, -0.5],
    "ne" => [0.5, 0.5],
    "w" => [-1.0, 0.0],
    "sw" => [-0.5, -0.5],
    "nw" => [-0.5, 0.5],
  }
  data.each do |d|
    x, y = [0.0, 0.0]

    while d != nil and d.size > 0
      slice_size = 1
      if ["n", "s"].include?(d[0])
        slice_size = 2
      end
      direction = d[0...slice_size]
      d = d[slice_size...d.size]
      x_diff, y_diff = direction_map[direction]
      x += x_diff
      y += y_diff
    end

    key = "#{x},#{y}"
    if not tiles.key?(key)
      tiles[key] = 0
    end
    tiles[key] += 1
  end
  return tiles.keys.select{ |key| tiles[key] % 2 == 1 }.size
end

# File IO
def format_lines(lines)
  lines.collect{ |line| line.strip }
end

file_path = "day24_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
