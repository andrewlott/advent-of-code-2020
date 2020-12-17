def neighbor_keys(key)
  x, y, z, w = key.split(",").collect{ |dimension| dimension.to_i}
  neighbors = []
  (x-1..x+1).each do |nx|
    (y-1..y+1).each do |ny|
      (z-1..z+1).each do |nz|
        (w-1..w+1).each do |nw|
          if x == nx and y == ny and z == nz and w == nw
            # Skip itself
            next
          end
          neighbors.append("#{nx},#{ny},#{nz},#{nw}")
        end
      end
    end
  end
  return neighbors
end

def search_space(pocket_dimension)
  xs = pocket_dimension.keys.collect{ |k| k.split(",").first.to_i }
  ys = pocket_dimension.keys.collect{ |k| k.split(",")[1].to_i }
  zs = pocket_dimension.keys.collect{ |k| k.split(",")[2].to_i }
  ws = pocket_dimension.keys.collect{ |k| k.split(",").last.to_i }
  return [
    (xs.min-1..xs.max+1),
    (ys.min-1..ys.max+1),
    (zs.min-1..zs.max+1),
    (ws.min-1..ws.max+1),
  ]
end

def solve(pocket_dimension)
  current_cycle = 0
  total_cycles = 6
  while current_cycle < total_cycles
    next_dimension = {}

    x_range, y_range, z_range, w_range = search_space(pocket_dimension)
    x_range.each do |x|
      y_range.each do |y|
        z_range.each do |z|
          w_range.each do |w|
            position = "#{x},#{y},#{z},#{w}"
            neighbor_positions = neighbor_keys(position)
            ([position] + neighbor_positions).each do |p|
              if not pocket_dimension.key?(p)
                pocket_dimension[p] = false
              end
            end

            is_active = pocket_dimension[position]
            total_active_neighbors = neighbor_positions.select{
              |np|
              pocket_dimension[np]
            }.size
            if is_active and not total_active_neighbors.between?(2,3)
              next_dimension[position] = false
            elsif not is_active and total_active_neighbors.between?(3,3)
              next_dimension[position] = true
            end
          end
        end
      end
    end
    # Update dimension
    next_dimension.each do |position, active|
      pocket_dimension[position] = active
    end
    current_cycle += 1
  end

  return pocket_dimension.values.select{ |active| active}.size
end

# File IO
def format_lines(lines)
  pocket_dimension = {
    # Coordinates are keys, value is bool
    # e.g. "x,y,z,w" => true
  }
  lines.each_with_index do |line, y|
    line.split("").each_with_index do |l, x|
      pocket_dimension["#{x},#{y},0,0"] = l == "#"
    end
  end
  return pocket_dimension
end

file_path = "day17_input_test.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
