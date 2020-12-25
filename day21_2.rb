def solve(data)
  allergen_ingredients = data.collect{
    |allergen, ingredient_lists|
    allergen_suspects = ingredient_lists.first
    ingredient_lists.each{
      |ingredient_list|
      allergen_suspects &= ingredient_list
    }
    [allergen, allergen_suspects]
  }.to_h
  while not allergen_ingredients.all?{ |_, ingredients| ingredients.size == 1 }
    allergen_ingredients.each do |allergen, ingredients|
      if ingredients.size == 1
        ingredient = ingredients.first
        allergen_ingredients.select{ |allergen2, _| allergen2 != allergen }.each do |allergen2, _|
          allergen_ingredients[allergen2] -= [ingredient]
        end
      end
    end
  end
  return allergen_ingredients.keys.sort.collect{ |allergen| allergen_ingredients[allergen]}.join(",")
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
