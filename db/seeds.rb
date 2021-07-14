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

20.times do
    Visitor.create(name: Faker::Name.unique.name, location_id: Location.ids.sample, password: "123")
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

25.times do 
    dog_age = rand(1..12)
    cat_age = rand(1..12)

    #dogs
    Animal.create(species: "Dog", name: "#{Faker::Creature::Dog.name}", age: dog_age, breed: "#{Faker::Creature::Dog.breed}", shelter_id: Shelter.ids.sample, adopted: false, price: Faker::Commerce.price)

    #cats
    Animal.create(species: "Cat", name: "#{Faker::Creature::Cat.name}", age: cat_age, breed: "#{Faker::Creature::Cat.breed}", shelter_id: Shelter.ids.sample, adopted: false, price: Faker::Commerce.price)
end


puts "Seeding adoptions..."

#create sample adoptions
#required arguments: date(string), price(integer), animal_id(integer), visitor_id(integer)

10.times do 
    animal_id = Animal.all.select {|animal| animal.adopted === false}.map {|animal| animal.id}.sample
    animal_price = Animal.all.find_by id: animal_id
    
    Adoption.create(date: Faker::Date.between(from: '2021-07-01', to: '2021-07-16'), price: animal_price.price, animal_id: animal_id, visitor_id: Visitor.ids.sample)

    adopted_animal = Animal.all.find{|animal| animal.id == animal_id}
    adopted_animal.adopted = true
    adopted_animal.save
end

puts "Done!"