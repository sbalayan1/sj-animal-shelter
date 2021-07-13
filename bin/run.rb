require_relative '../config/environment'

prompt = TTY::Prompt.new

puts 'hello world'
puts 'hi sean changed this'

name_response = prompt.ask('What is your name?')

puts name_response

menu_choice = prompt.select("What would you liked to do?", ["Login", "Signup"])

if menu_choice === "Login"
    user_name = prompt.ask("Username:")
    password = prompt.mask("Password:")

    User.all.find {|user| user.name === user_name && user.password === password}

    puts "hello #{current_user.name}"


    animal_choice = prompt.select("Select a doctor below:", Animal.all)
    date_choice = prompt.select("Choose a date", [Date.parse("06/13/2021"),Date.parse("06/14/2021"),Date.parse("06/15/2021")])

    adpt_confirmation = prompt.select("Are you sure you want to adopt #{animal_choice.name} at #{date_choice}", ["Yes", "No"])

    if appt_confirmation === "Yes"
        Adoption.create(animal_id: animal_choice.id, visitor_id: current_user.id, date: date_choice)

        puts "congrats on your adoption!!!"
    end
end