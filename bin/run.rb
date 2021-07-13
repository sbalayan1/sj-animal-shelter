require_relative '../config/environment'

prompt = TTY::Prompt.new
current_user = nil

# starter menu prompt
menu_choice = prompt.select("Hello! Welcome to the WestCoast WyldLyfe! Please select an option below.", ["About","Login", "Signup", "Exit"])


# about section
if menu_choice === "About"
    puts "WestCoast WyldLyfe is an application that helps YOU find your new animal companion. By finding the nearest animal shelters to you, we hope to make the process of finding and giving these lovely animals a new home as easy as possible. Established in the summer of 2021, WestCoast Wyldlyfe has already helped dozens of animals find a new family."

    decision = prompt.yes?("Are you ready to start yours?")

    if decision 
        menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
    else 
        exit
    end
end 

# login section
if menu_choice === "Login"
    user_name = prompt.ask("Username:")
    password = prompt.mask("Password:")

    if Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password}
        current_user = Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password} 
        puts "Welcome to WestCoast WyldLyfe #{current_user.name}!!!"

        current_user_shelters = Shelter.all.select {|shelter| shelter.location_id == current_user.location_id}
        puts current_user_shelters
        # shelter_menu_choice = prompt.select("These are your local shelters. Which one are you looking at today?", current_user_shelters)

        # if shelter_menu_choice == "Santiago Ward Animal Shelter"
        #     selected_shelter = Shelter.find_by(name: "Santiago Ward Animal Shelter")

        #     shelter_animal_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "See all my adoptions", "Exit"])
        # end

        # if shelter_menu_choice == "Miss Darren Donnelly Animal Shelter"
        #     selected_shelter = Shelter.find_by(name: "Miss Darren Donnelly Animal Shelter")

        #     menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "See all my adoptions", "Exit"])
        # end

        # if shelter_menu_choice == "Justine Johnston Animal Shelter"
        #     selected_shelter = Shelter.find_by(name: "Justine Johnston Animal Shelter")

        #     menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "See all my adoptions", "Exit"])

        # end

    else 
        puts "That user does not exist or there was an error in your password "
        menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
    end 
end

#sign up section
if menu_choice === "Signup"
    new_user = prompt.ask("Enter your new username:", required: true)
    new_password = prompt.mask("Enter your new password:", required: true)
    reinput_password = prompt.mask("Re-enter your password to confirm:", required: true)

    if reinput_password === new_password && Visitor.all.find_by(name: new_user) === nil
        new_user_location = prompt.select("Select the zip-code that corresponds to your city!\n San Francisco: 94127\n Los Angeles: 90048", [94127, 90048])
        Visitor.create(name: new_user, location_id: new_user_location, password: new_password)
        puts "Thank you for signing up to WestCoast WyldLyfe! Please login using your new login information." 
        menu_choice = prompt.select("Please select an option below.", ["Login", "Exit"])
    else 
        puts "The passwords do not match or you have not entered in a valid username. Please try again."
        menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
    end
end

#adoption section 
if menu_choice === "See all my adoptions"
    if current_user.adoptions === []
        puts "You have no adoptions!" 
    else
        puts current_user.adoptions
    end
end

if menu_choice === "See available dogs"

    shelter_animals = Animal.all.select {|animal| animal.shelter_id == selected_shelter.id}.map {|animal| "#{animal.species} / #{animal.name}"}

    prompt.select("Good choice, these are the available animals at this time. Select one to adopt!", shelter_animals)
    
end 

if menu_choice === "See available cats"
end

# exit section
if menu_choice == "Exit"
  exit
end

