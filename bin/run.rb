require_relative '../config/environment'

prompt = TTY::Prompt.new
current_user = nil

menu_choice = prompt.select("Hello! Welcome to the WestCoast WyldLyfe! Please select an option below.", ["About","Login", "Signup", "Exit"])

if menu_choice === "About"
    puts "WestCoast WyldLyfe is an application that helps YOU find your new animal companion. By finding the nearest animal shelters to you, we hope to make the process of finding and giving these lovely animals a new home as easy as possible. Established in the summer of 2021, WestCoast Wyldlyfe has already helped dozens of animals find a new family."

    decision = prompt.yes?("Are you ready to start yours?")
    if decision 
        menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
    else
    end
end 

if menu_choice === "Login"
    user_name = prompt.ask("Username:")
    password = prompt.mask("Password:")

    current_user = Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password}

    puts "Hello #{current_user.name}"


    animal_choice = prompt.select("Select an below:", Animal.all)

    # date_choice = prompt.select("Choose a date", [Date.parse("06/13/2010"), Date.parse("06/14/2021"), Date.parse("06/15/2021")])

    adpt_confirmation = prompt.select("Are you sure you want to adopt #{animal_choice.name} at #{date_choice}", ["Yes", "No"])

    if appt_confirmation === "Yes"
        Adoption.create(animal_id: animal_choice.id, visitor_id: current_user.id, date: date_choice)

        puts "congrats on your adoption!!!"
    end
end

if menu_choice === "Signup"
    new_user = prompt.ask("new_username:")
    new_user_location = prompt.select("Choose from the zip codes below! San Francisco: 94127 Los Angeles: 90048", [94127, 90048])
    new_password = prompt.mask("new_password")
    reinput_password = prompt.mask("reinput_password")

    if reinput_password === new_password
        puts "Thank you for signing up to WestCoast WyldLyfe! Please login using your new login information." 
        menu_choice = "Login"
    else 
        puts "The passwords do not match. "
        menu_choice = "Signup"
        new_user = new_user
        new_user_location = new_user_location
    end
end

if menu_choice == "Exit"

end