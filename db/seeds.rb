puts "Clearing old data..."
Animal.destroy_all
Shelter.destroy_all
Adoption.destroy_all
Visitor.destroy_all
Location.destroy_all

puts "Seeding locations..."

#create sample locations
#required arguments: zip_code

san_francisco_zip_code = 94127
los_angeles_zip_code = 90048

location_1= Location.create(zip_code: san_francisco_zip_code)
location_2 = Location.create(zip_code: los_angeles_zip_code)

puts "Seeding visitors..."

#create sample visitors
#required arguments: name(string), location_id(integer)

10.times do
    Visitor.create(name: Faker::Name.unique.name, location_id: Location.ids.sample)
end

puts "Seeding shelters..."

#create sample shelters
#required arguments: name(string), location_id(integer)

5.times do 
    Shelter.create(name: "#{Faker::Name.unique.name} Animal Shelter", location_id: Location.ids.sample)
end

puts "Seeding animals..."

#create sample animals
#required arguments: species(string), name(string), age(integer), breed(string), shelter_id(integer)

#dogs
25.times do 
    Animal.create(species: "Dog", name: "#{Faker::Creature::Dog.unique.name}", age: "#{Faker::Creature::Dog.age}", breed: "#{Faker::Creature::Dog.breed}", shelter_id: Shelter.ids.sample)
end

#cats
cat_age = [1..12]
25.times do 
    Animal.create(species: "Cat", name: "#{Faker::Creature::Cat.unique.name}", age: cat_age.sample, breed: "#{Faker::Creature::Cat.breed}", shelter_id: Shelter.ids.sample)
end

puts "Seeding adoptions..."
#create sample adoptions

puts "Done!"