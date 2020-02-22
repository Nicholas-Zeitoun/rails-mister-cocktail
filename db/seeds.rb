# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'byebug'

puts 'Cleaning database...'
# Cocktail.destroy_all if Rails.env.development?

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
cocktails_serialized = open(url).read
cocktails = JSON.parse(cocktails_serialized)

cocktails["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Shaking Cocktails"

def find_ingredient_id(ingredient_name)
  ingredient = Ingredient.where(name: ingredient_name).first
  ingredient.id
end

data = File.read("public/cocktail_seeds.json")
new_cocktails = JSON.parse(data)

new_cocktails["cocktails"].each do |new_cocktail|
  created_cocktail = Cocktail.create!(
    name: new_cocktail['name'],
    description: new_cocktail['description'],
    image_url: new_cocktail['image_url']
  )
  new_cocktail["doses"].each do |dose|
    # byebug
    Dose.create!(
      description: dose["description"],
      ingredient_id: find_ingredient_id(dose["ingredient_name"]),
      cocktail_id: created_cocktail.id
    )
  end
end
# Cocktail.create!(name: "Mojito", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-mojito-on-table-royalty-free-image-998866018-1557246957.jpg?crop=1xw:1xh;center,top&resize=980:*")
# Cocktail.create!(name: "Old Fashioned", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-164770405-1-1508961546.jpg?crop=1xw:1xh;center,top&resize=980:*")
# Cocktail.create!(name: "Margarita", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-516883622-1508961864.jpg?crop=0.44377777777777777xw:1xh;center,top&resize=980:*")
# Cocktail.create!(name: "Cosmopolitan", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/an-alcoholic-cosmopolitan-cocktail-is-on-the-bar-royalty-free-image-890771104-1557247368.jpg?crop=0.447xw:1.00xh;0.446xw,0&resize=980:*")
# Cocktail.create!(name: "Negroni", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cocktail-negroni-on-a-old-wooden-board-drink-with-royalty-free-image-922744216-1557251200.jpg?crop=0.447xw:1.00xh;0.434xw,0&resize=980:*")
# Cocktail.create!(name: "Moscow Mule", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-834848932-1508962243.jpg?crop=0.9998698425094363xw:1xh;center,top&resize=980:*")
# Cocktail.create!(name: "Whiskey Sour", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-126551868-1-1508962528.jpg?crop=1.00xw:0.949xh;0,0.0259xh&resize=980:*")
# Cocktail.create!(name: "Mimosa", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/homemade-refreshing-orange-mimosa-cocktails-royalty-free-image-538644352-1557251390.jpg?crop=0.447xw:1.00xh;0.111xw,0&resize=980:*")
# Cocktail.create!(name: "Martini", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/martini-glasses-royalty-free-image-71917252-1557251652.jpg?crop=0.447xw:1.00xh;0.379xw,0&resize=980:*")
# Cocktail.create!(name: "Martinez", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-539980873-1508961925.jpg?crop=0.9410548086866598xw:1xh;center,top&resize=980:*")
# Cocktail.create!(name: "Paloma", image_url: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/cocktail-sparkling-pink-paloma-royalty-free-image-1000649118-1557250108.jpg?crop=1xw:1xh;center,top&resize=980:*")
puts "Drinks are ready!"
