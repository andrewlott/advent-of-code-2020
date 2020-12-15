def solve(data)
  arrival_time, bus_ids = data

  departure_time = arrival_time
  next_bus_id = bus_ids.select{ |id| departure_time % id == 0}.first
  until next_bus_id != nil
    departure_time += 1
    next_bus_id = bus_ids.select{ |id| departure_time % id == 0}.first
  end
  (departure_time - arrival_time) * next_bus_id
end

# File IO
def format_lines(lines)
  data = [
    lines.first.to_i,
    lines.last.split(",").select{ |id| /\d+/.match?(id)}.collect{ |id| id.to_i}
  ]
  return data
end

file_path = "day13_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
