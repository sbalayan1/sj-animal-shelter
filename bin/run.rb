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
        exit
    end
end 

if menu_choice === "Login"
    user_name = prompt.ask("Username:")
    password = prompt.mask("Password:")

    if Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password}
        current_user = Visitor.all.find {|visitor| visitor.name === user_name && visitor.password === password} 
        puts "Welcome to WestCoast WyldLyfe #{current_user.name}!!!"

        menu_choice = prompt.select("Please select an option below.", ["See available dogs", "See available cats", "See all my adoptions", "Exit"])
    else 
        puts "That user does not exist. "
        menu_choice = prompt.select("Please select an option below.", ["Login", "Signup", "Exit"])
    end 

    # animal_choice = prompt.select("Select a doctor below:", Animal.all)
    # date_choice = prompt.select("Choose a date", [Date.parse("06/13/2021"),Date.parse("06/14/2021"),Date.parse("06/15/2021")])

    animal_choice = prompt.select("Select an below:", Animal.all)

    # date_choice = prompt.select("Choose a date", [Date.parse("06/13/2010"), Date.parse("06/14/2021"), Date.parse("06/15/2021")])

    # if appt_confirmation === "Yes"
    #     Adoption.create(animal_id: animal_choice.id, visitor_id: current_user.id, date: date_choice)

    #     puts "congrats on your adoption!!!"
    # end
end

if menu_choice === "Signup"
    new_user = prompt.ask("Enter your new username:")
    new_password = prompt.mask("Enter your new password:")
    reinput_password = prompt.mask("Re-enter your password to confirm:")
    new_user_location = prompt.select("Select the zip-code that corresponds to your city!\n San Francisco: 94127\n Los Angeles: 90048", [94127, 90048])

    if reinput_password === new_password
        puts "Thank you for signing up to WestCoast WyldLyfe! Please login using your new login information." 

    else 
        puts "The passwords do not match. "
    end
end

if menu_choice == "Exit"
    exit
end