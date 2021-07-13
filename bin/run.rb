require_relative '../config/environment'

prompt = TTY::Prompt.new


name_response = prompt.ask('What is your name?')
menu_choice = prompt.select("Hello! Welcome to the WestCoast WyldLyfe! Please select an option below.", ["About","Login", "Signup", "Exit"])

if menu_choice === "About"
    'hello world'

elsif menu_choice === "Login"
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
elsif menu_choice === "Signup"
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
else 
    exit
end