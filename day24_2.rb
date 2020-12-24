def debug(s)
  if false
    puts s
  end
end

def get_initial_tiles(direction_map, data)
  tiles = {}
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
  return tiles
end

def get_neighbor_keys(key, direction_map)
  tile_x, tile_y = key.split(",").collect{ |t| t.to_f }
  return direction_map.values.collect{
    |v|
    "#{tile_x + v.first},#{tile_y + v.last}"
  }
end

def solve(data)
  direction_map = {
    "e" => [1.0, 0.0],
    "se" => [0.5, -0.5],
    "ne" => [0.5, 0.5],
    "w" => [-1.0, 0.0],
    "sw" => [-0.5, -0.5],
    "nw" => [-0.5, 0.5],
  }

  tiles = get_initial_tiles(direction_map, data)
  days = 100
  day = 0
  total_black_tiles = tiles.keys.select{ |key| tiles[key] % 2 == 1 }.size
  while day < days
    tiles_copy = tiles.clone
    # Add neighbors as white
    tiles.each do |key, _|
      neighbor_keys = get_neighbor_keys(key, direction_map)
      neighbor_keys.select{ |k| not tiles_copy.key?(k) }.each do |k|
        tiles_copy[k] = 0
      end
    end
    tiles = tiles_copy
    tiles_copy = tiles.clone
    # Flip
    tiles.each do |key, value|
      num_black_neighbor_tiles = get_neighbor_keys(key, direction_map).select{
        |k|
        tiles[k].to_i % 2 == 1
      }.size
      if value % 2 == 1 and (num_black_neighbor_tiles == 0 or num_black_neighbor_tiles > 2)
      # Black tile
        tiles_copy[key] += 1
      elsif value % 2 == 0 and num_black_neighbor_tiles == 2
        # White tile
        tiles_copy[key] += 1
      end
    end
    tiles = tiles_copy
    day += 1
    total_black_tiles = tiles.keys.select{ |key| tiles[key] % 2 == 1 }.size
    puts "Day #{day}: #{total_black_tiles}"
  end
  return total_black_tiles
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
