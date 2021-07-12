puts "Clearing old data..."
Animal.destroy_all
Shelter.destroy_all
Adoption.destroy_all
Visitor.destroy_all
Location.destroy_all

puts "Seeding shelters..."
#create sample shelters

puts "Seeding animals..."
#create sample animals

puts "Seeding adoptions..."
#create sample adoptions

puts "Seeding visitors..."
#create sample visitors

puts "Seeding locations..."
#create sample locations
