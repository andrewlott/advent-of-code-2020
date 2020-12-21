def can_be_neighbors(a, b_)
  b_clone = b_.clone
  neighbors = []
  (0...4).each do
    [
      b_clone,
      b_clone.reverse,
      b_clone.collect{ |l| l.reverse }
    ].each do |b|
      top = a.first == b.last
      bottom = a.last == b.first
      right = a.collect{ |l| l[-1] }.join == b.collect{ |l| l[0] }.join
      left = a.collect{ |l| l[0] }.join == b.collect{ |l| l[-1] }.join
      neighbors.append([top, right, bottom, left])
    end
    b_clone = b_clone.collect{ |l| l.split("") }.transpose.reverse.collect{ |l| l.join }
  end
  return neighbors
end

def solve(data)
  valid_neighbors = data.collect{
    |key, tilea|
    [
      key,
      data.select{
        # Filter out current key
        |k, v|
            k != key
      }.collect{
        |k, tileb|
        [k, can_be_neighbors(tilea, tileb)]
      }.to_h
    ]
  }.to_h

  matchless_sides = {}
  valid_neighbors.each do |key, neighbors|
    top_line_matchless = neighbors.collect{
      |_, values|
      values.all?{ |v| not v.first }
    }.all?
    right_line_matchless = neighbors.collect{
      |_, values|
      values.all?{ |v| not v[1] }
    }.all?
    bottom_line_matchless = neighbors.collect{
      |_, values|
      values.all?{ |v| not v[2] }
    }.all?
    left_line_matchless = neighbors.collect{
      |_, values|
      values.all?{ |v| not v.last }
    }.all?
    matchless_sides[key] = [
      top_line_matchless,
      right_line_matchless,
      bottom_line_matchless,
      left_line_matchless
    ].select{ |m| m }.size
  end
  matchless_sides.select{ |k, v| v == 2 }.collect{ |k, v| k}.reduce{ |acc, v| acc * v}
end

# File IO
def format_lines(lines)
  data = {}
  while lines != nil
    newline_index = lines.index("\n")
    if newline_index == nil
      newline_index = lines.size
    end
    tile_info = lines[0...newline_index]
    key = tile_info[0].scan(/\d+/).first.to_i
    data[key] = tile_info[1...tile_info.size].collect{ |l| l.strip }
    lines = lines[newline_index + 1...lines.size]
  end
  data
end

file_path = "day20_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
