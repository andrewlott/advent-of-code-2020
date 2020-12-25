def solve(data)
  all_ingredients = data.values.flatten.uniq
  unsafe_ingredients = data.collect{
    |allergen, ingredient_lists|
    allergen_suspects = ingredient_lists.first
    ingredient_lists.each{
      |ingredient_list|
      allergen_suspects &= ingredient_list
    }
    allergen_suspects
  }.flatten.uniq
  safe_ingredients = all_ingredients - unsafe_ingredients

  all_lists = []
  data.each do |allergen, ingredient_lists|
    ingredient_lists.each do |ingredient_list|
      all_lists.append(ingredient_list)
    end
  end
  occurrences = 0
  safe_ingredients.each do |ingredient|
    all_lists.uniq.each do |ingredient_list|
      occurrences += ingredient_list.count(ingredient)
    end
  end
  return occurrences
end

# File IO
def format_lines(lines)
  data = {}
  lines.each do |line|
    ingredients_line, allergens_line = line.split("(contains")
    allergens = allergens_line.strip.scan(/\w+/)
    ingredients = ingredients_line.strip.split(" ")
    allergens.each do |allergen|
      if not data.key?(allergen)
        data[allergen] = []
      end
      data[allergen].append(ingredients)
    end
  end
  return data
end

file_path = "day21_input.txt"
lines = File.readlines(file_path)
data = format_lines(lines)
answer = solve(data)
puts answer
