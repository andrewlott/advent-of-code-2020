def solve(data)
  required = {
    "byr" => lambda { |x| x.to_i.between?(1920, 2002)},
    "iyr" => lambda { |x| x.to_i.between?(2010, 2020)},
    "eyr" => lambda { |x| x.to_i.between?(2020, 2030)},
    "hgt" => lambda {
      |x|
      (
        (x[-2..x.size] == "cm" and x[0...-2].to_i.between?(150, 193)) or
        (x[-2..x.size] == "in" and x[0...-2].to_i.between?(59, 76))
      )
    },
    "hcl" => lambda { |x| /^#[0-9a-f]{6}$/.match?(x)},
    "ecl" => lambda { |x| ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(x)},
    "pid" => lambda { |x| /^\d{9}$/.match?(x)},
    #"cid", # hohoho
  }
  valid = 0
  data.each do |d|
    if required.all?{ |k,v| d.key?(k) and v.(d[k])}
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
