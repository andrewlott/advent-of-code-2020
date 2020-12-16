def is_valid(ticket, notes)
  ticket.all?{
    |num|
    notes.values.any? {
      |ranges|
      ranges.any?{
        |range|
        num.between?(range.first, range.last)
      }
    }
  }
end

def get_possible_field_names(ticket_fields, notes)
  ticket_fields.collect{
    |field_values|
    notes.select {
      |field_name, ranges|
      field_values.all? {
        |field_value|
        ranges.any?{
          |range|
          field_value.between?(range.first, range.last)
        }
      }
    }.collect{ |field_name, _| field_name }
  }
end

def choose_field_names(possible_field_names)
  while possible_field_names.any?{ |fns| fns.size > 1 }
    possible_field_names.select{ |field_names| field_names.size == 1 }.each do |field_names|
      field_name = field_names.first
      possible_field_names.each do |other_field_names|
        if other_field_names == field_names
          next
        end
        other_field_names.delete(field_name)
      end
    end
  end
  possible_field_names.flatten
end

def solve(data)
  my_ticket = data["my_ticket"]
  tickets = [my_ticket] + data["nearby_tickets"].select{|ticket| is_valid(ticket, data["notes"]) }

  num_fields = my_ticket.size
  ticket_fields = [nil] * num_fields
  (0...num_fields).each do |i|
    ticket_fields[i] = tickets.collect{ |ticket| ticket[i] }
  end

  possible_field_names = get_possible_field_names(ticket_fields, data["notes"])
  field_names = choose_field_names(possible_field_names)

  departure_mul = 1
  field_names.each_with_index do |field_name, i|
    if /departure/.match?(field_name)
      departure_mul *= my_ticket[i]
    end
  end
  return departure_mul
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
