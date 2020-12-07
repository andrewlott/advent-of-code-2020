def b_search(data, min, max, down_s, up_s)
  lower = min
  upper = max
  d_index = 0
  while lower < upper
    s = data[d_index]
    diff = upper - lower
    if s == up_s
      lower += [1, diff / 2].max
    else
      upper -= [1, diff / 2].max
    end
    d_index += 1
  end
  raise "No answer" unless lower == upper
  lower
end

def solve(data)
  row_count = 128
  col_count = 8
  available_row_ids = (0...row_count * col_count).to_a
  data.each do |d|
    d_row = d[0...7]
    d_col = d[7...d.size]
    row = b_search(d_row, 0, row_count, "F", "B")
    col = b_search(d_col, 0, col_count, "L", "R")
    row_id = row * 8 + col
    raise "Row not in expected list: #{row_id} in #{available_row_ids}" unless available_row_ids.include?(row_id)
    available_row_ids.delete(row_id)
  end

  my_rows = available_row_ids.select { |v| not available_row_ids.include?(v - 1) and not available_row_ids.include?(v + 1)}
  raise "Multiple rows found: #{my_rows}" unless my_rows.size == 1
  my_rows.first
end

# File IO
def format_lines(lines)
  lines
end

file_path = "day5_2_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
