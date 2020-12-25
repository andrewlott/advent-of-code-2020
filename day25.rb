def transform(value, subject_number, loops)
  (0...loops).each do |_|
    value *= subject_number
    value = value % 20201227
  end
  return value
end

def get_loop_size(public_key)
  subject_number = 7
  value = 1
  loop_size = 0
  while value != public_key
    loop_size += 1
    value = transform(value, subject_number, 1)
  end
  return loop_size
end

def solve(data)
  door_public_key, card_public_key = data
  door_loop_size = get_loop_size(door_public_key)
  return transform(1, card_public_key, door_loop_size)
end

# File IO
def format_lines(lines)
  lines.collect{ |line| line.to_i }
end

file_path = "day25_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
