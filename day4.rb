def solve(data)
  required_keys = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
    #"cid", # hohoho
  ]
  valid = 0
  data.each do |d|
    if required_keys.all?{ |k| d.key?(k)}
      valid += 1
    end
  end
  valid
end

# File IO
def format_lines(lines)
  data = lines.join("").split("\n\n").collect{ |e| e.split(/\s/).collect{ |v| v.split(":")}.to_h}
  data
end

file_path = "day4_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
