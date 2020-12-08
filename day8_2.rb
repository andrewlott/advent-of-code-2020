# This is effectively DFS graph traversal
# More optimal solution is to DFS from destination to origin

def solve_rec(data, visited_indices, acc, index, modified)
  while not visited_indices.key?(index) and index < data.size
    visited_indices[index] = 1
    operation, value = data[index]

    if operation == "acc"
      acc += value
      index += 1
    elsif operation == "jmp"
      if not modified
        original_operation = data[index].first
        # Try nop
        data[index][0] = "nop"
        answer = solve_rec(data.clone, visited_indices.clone, acc, index + 1, true)

        data[index][0] = original_operation
        if answer
          return answer
        end
      end
      # Do jmp
      index += value
    elsif operation == "nop"
      if not modified
        original_operation = data[index].first
        # Try jmp
        data[index][0] = "jmp"
        answer = solve_rec(data.clone, visited_indices.clone, acc, index + value, true)

        data[index][0] = original_operation
        if answer
          return answer
        end
      end
      # Do nop
      index += 1
    else
      raise "Unknown operation #{operation}"
    end
  end

  if index >= data.size
    return acc
  else
    return nil
  end
end

def solve(data)
  solve_rec(data, {}, 0, 0, false)
end

# File IO
def format_lines(lines)
  data = []
  lines.each do |l|
    operation, value = /^(\w+) ([+-]\d+)$/.match(l).captures
    data.append([operation, value.to_i])
  end
  data
end

file_path = "day8_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
