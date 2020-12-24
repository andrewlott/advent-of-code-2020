def debug(s)
  if true
    puts s
  end
end

def get_destination_cup(current_cup, cups)
  destination_cup = current_cup - 1
  while not cups.include?(destination_cup) and destination_cup >= cups.min
    destination_cup -= 1
  end
  if destination_cup < cups.min
    destination_cup = cups.max
  end
  return destination_cup
end

def solve(cups)
  moves = 100
  move = 0
  current_cup = cups.first
  pickup_amount = 3
  while move < moves
    cups_string = cups.collect{ |c| c == current_cup ? "(#{c})" : "#{c}"}.join(" ")

    pickup_index = (cups.index(current_cup)+1)%cups.size
    picked_up_cups = (pickup_index...pickup_index+pickup_amount).collect{ |i| cups[i%cups.size] }
    cups = cups.select{ |c| not picked_up_cups.include?(c) }
    destination_cup = get_destination_cup(current_cup, cups)

    # Debug
    debug "cups: #{cups_string}"
    debug "pick up: #{picked_up_cups.join(", ")}"
    debug "destination: #{destination_cup}"
    debug ""

    # Update
    cups.insert((cups.index(destination_cup)+1)%cups.size, *picked_up_cups)
    current_cup = cups[(cups.index(current_cup)+1)%cups.size]
    move += 1
  end
  return (1...cups.size).collect{ |i| cups[(cups.index(cups.min)+i)%cups.size]}.join("")
end

# File IO
def format_lines(lines)
  lines.first.strip.split("").collect{ |l| l.to_i}
end

file_path = "day23_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
