def validate_message_rec(message, m_index, rules, rule_key)
  rules[rule_key].each do |rule|
    rule_is_valid = true
    last_index = m_index

    if rule.kind_of?(Array)
      rule.each_with_index do |r, index|
        is_valid, last_index = validate_message_rec(message, last_index, rules, r)
        if not is_valid
          rule_is_valid = false
        end
      end
    else
      rule_is_valid, last_index = [message[m_index] == rule, m_index + 1]
    end

    if rule_is_valid
      puts message
      puts rule
      puts "Valid rule #{rule} #{m_index} #{last_index}"
      return [true, last_index]
    end
  end

  return [false, -1]
end

def validate_message(message, rules)
  valid, last_index = validate_message_rec(message, 0, rules, 0.to_s)
  puts "Message: #{message}, #{valid}, #{last_index}, #{message.size}"
  return (valid and last_index == message.size - 1)
end

def solve(data)
  rules, messages = data
  pass = messages.select{ |m| validate_message(m, rules)}
  puts pass.size
end

# File IO
def format_lines(lines)
  newline_index = lines.index("\n")
  rules = {}
  lines[0...newline_index].each do |line|
    key, line = line.split(":").collect{ |s| s.strip}
    if /[\d \|]+/.match?(line)
      rules[key] = line.split("|").collect{ |s| s.strip.split(" ") }
    elsif /^"\w"$/.match?(line)
      rules[key] = line.scan(/"(\w)"/).first
    else
      raise "Unexpected input: #{line}"
    end
  end

  [rules, lines[newline_index + 1...lines.size]]
end

file_path = "day19_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
