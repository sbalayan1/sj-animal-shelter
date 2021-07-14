require_relative '../config/environment'

prompt = TTY::Prompt.new
current_user = nil
adoption_choice = nil

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

#sign up section
    if menu_choice === "Signup"
        new_user = prompt.ask("Enter your new username:", required: true)
        new_password = prompt.mask("Enter your new password:", required: true)
        reinput_password = prompt.mask("Re-enter your password to confirm:", required: true)

        if reinput_password === new_password && Visitor.all.find_by(name: new_user) === nil
            new_user_location = prompt.select("Select the zip-code that corresponds to your city!\n San Francisco: 94127\n Los Angeles: 90048", [94127, 90048])

            match_location = Location.all.select {|location| location.zip_code == new_user_location}.map {|location| location.id}.join.to_i

            Visitor.create(name: new_user, location_id: match_location, password: new_password)
            puts "Thank you for signing up to WestCoast WyldLyfe! Please login using your new login information." 
            menu_choice = prompt.select("Please select an option below.", ["Login", "Exit"])
        else 
            puts "The passwords do not match or you have not entered in a valid username. Please try again."
            menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
        end
    end

# login section
    if menu_choice === "Login"
        user_name = prompt.ask("Username:")
        password = prompt.mask("Password:")

        if Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password}
            current_user = Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password} 
            puts "Welcome back to WestCoast WyldLyfe #{current_user.name}!"

            current_user_shelters = Shelter.all.select {|shelter| shelter.location_id == current_user.location_id}.map {|shelter| shelter.name}
            menu_choice = prompt.select("These are your local shelters. Which one are you looking at today?", current_user_shelters)

        else 
            puts "That user does not exist. "
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

            match_location = Location.all.select {|location| location.zip_code == new_user_location}.map {|location| location.id}.join.to_i

            Visitor.create(name: new_user, location_id: match_location, password: new_password)
            puts "Thank you for signing up to WestCoast WyldLyfe! Please login using your new login information." 
            menu_choice = prompt.select("Please select an option below.", ["Login", "Exit"])
        else 
            puts "The passwords do not match or you have not entered in a valid username. Please try again."
            menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])

        end
    end

#shelter section
    if menu_choice.end_with? "Shelter"
        selected_shelter = Shelter.all.find_by name: menu_choice
        menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "See all my adoptions", "Exit"])
    end 

#adoption section 
    ##see adoptions
    if menu_choice === "See all my adoptions"
        if current_user.adoptions === []
            puts "You have no adoptions!" 
            menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "Exit"])
        else
            puts current_user.adoptions
            menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "Exit"])
        end
    end

    ##see dogs
    if menu_choice === "See available dogs"

        shelter_animals = Animal.all.select {|animal| animal.shelter_id == selected_shelter.id}.select {|animal| animal.species == "Dog"}.select {|animal| animal.adopted == false}.map {|animal| animal.name}

        if shelter_animals != []
            menu_choice = prompt.select("Good choice, these are the available animals at this time. Select one to adopt!", [shelter_animals, "See available cats", "Exit"])
        else 
            menu_choice = prompt.select("Unfortunately there are no animals available at this time", ["See all my adoptions", "See available cats", "Exit"])
        end
    end 


    ##see cats
    if menu_choice === "See available cats"
        shelter_animals = Animal.all.select {|animal| animal.shelter_id == selected_shelter.id}.select {|animal| animal.species == "Cat"}.select {|animal| animal.adopted == false}.map {|animal| animal.name}
        
        if shelter_animals != []
            
            adoption_choice = prompt.select("Good choice, these are the available animals at this time. Select one to adopt!", [shelter_animals, "See available dogs", "Exit"])
        else 
            menu_choice = prompt.select("Unfortunately there are no animals available at this time", ["See all my adoptions", "See available dogs", "Exit"])
        end 

    end

    if menu_choice === shelter_animals
        adopted_animal = Animal.all.find_by name: adoption_choice
        Adoption.create(date: Date.today, price: adopted_animal.price, animal_id: adopted_animal.id, visitor_id: current_user.id)
        adopted_animal.adopted = true
        adopted_animal.save

        menu_choice = prompt.select("Please select an option below.", ["See all my adoptions", "Exit"])
    end 

    ##see adoptions
    if menu_choice === "See all my adoptions"
        if current_user.adoptions === []
            puts "You have no adoptions!" 
            menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "Exit"])
        else

            adoption_ids = current_user.adoptions.collect {|adoption| adoption.animal_id}

            for element in adoption_ids do 
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.name}
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.age}
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.breed}
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.shelter_id}
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.species}
                puts Animal.all.select {|animal| animal.id === element}.map {|animal| animal.price}
            end 

            menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "Exit"])
        end
    end
    
# exit section
    if menu_choice == "Exit"
        exit
    end

