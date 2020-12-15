def solve(data)
  num_bits = 36
  mask = [0] * num_bits
  mem = {}
  data.each do |d|
    command = d.first
    if command == "mask"
      _, new_mask = d
      mask = new_mask
    elsif command == "mem"
      _, index, value = d
      value_b_array = value.to_s(2).split("").collect{ |b| b.to_i}.reverse
      value_b_array = (0...num_bits).collect{
        |i|
        i < value_b_array.size ?
          value_b_array[i] :
          0
      }.reverse
      (0...value_b_array.size).each do |i|
        b = mask[i]
        if b != nil
          value_b_array[i] = b
        end
      end
      mem[index] = value_b_array.join.to_i(2)
    else
      raise "Unknown command"
    end
  end
  mem.values.sum
end

# File IO
def format_lines(lines)
  lines.collect{
    |line|
    /mask/.match?(line) ?
      ["mask"] +
      [line.split("=").last.strip.split("").collect{ |b| b == "X" ? nil : b.to_i}]
    :
      ["mem"] +
      line.scan(/\[(\d+)\]/).first.collect{ |v| v.to_i } +
      line.scan(/=\s*(\d+)/).first.collect{ |v| v.to_i}
  }
end

file_path = "day14_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
