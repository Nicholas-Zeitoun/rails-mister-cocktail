require 'json'
require 'open-uri'

puts 'Fetching ingredients...'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
cocktails_serialized = open(url).read
cocktails = JSON.parse(cocktails_serialized)

cocktails['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

puts 'Shaking Cocktails'

def find_ingredient_id(ingredient_name)
  ingredient = Ingredient.where(name: ingredient_name).first
  ingredient.id
end

data = File.read('public/cocktail_seeds.json')
new_cocktails = JSON.parse(data)

new_cocktails['cocktails'].each do |new_cocktail|
  created_cocktail = Cocktail.create!(
    name: new_cocktail['name'],
    description: new_cocktail['description'],
    image_url: new_cocktail['image_url']
  )
  new_cocktail['doses'].each do |dose|
    Dose.create!(
      description: dose['description'],
      ingredient_id: find_ingredient_id(dose['ingredient_name']),
      cocktail_id: created_cocktail.id
    )
  end
end
puts 'Drinks are ready!'
