def solve(data)
  invalid_total = 0
  data["nearby_tickets"].each do |nt|
    invalid_values = nt.select{
      |num|
      not data["notes"].values.any? {
        |ranges|
        ranges.any?{
          |range|
          num.between?(range.first, range.last)
        }
      }
    }
    invalid_values.each do |value|
      invalid_total += value
    end
  end
  invalid_total
end

# File IO
def format_lines(lines)
  newline_index = lines.index("\n")
  notes, lines = lines[0...newline_index], lines[newline_index + 1...lines.size]
  newline_index = lines.index("\n")
  my_ticket, nearby_tickets = lines[0...newline_index], lines[newline_index + 1...lines.size]

  data = {
    "notes" => {},
    "my_ticket" => [],
    "nearby_tickets" => []
  }
  notes.each do |note|
    field = note.split(":").first
    ranges = note.scan(/(\d+)-(\d+)/).collect{ |c| c.collect{ |n| n.to_i }}
    data["notes"][field] = ranges
  end
  data["my_ticket"] = my_ticket.last.split(",").collect{ |n| n.to_i}

  nearby_tickets[1...nearby_tickets.size].each do |nearby_ticket|
    data["nearby_tickets"] += [nearby_ticket.split(",").collect{ |n| n.to_i}]
  end
  data
end

file_path = "day16_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
