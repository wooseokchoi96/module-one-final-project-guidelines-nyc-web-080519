def welcome
    system('clear')
    puts 'Welcome to the Anime Query Machine!'
    puts 'You can search for anime information and write reviews!'
    puts 'Please login (l) or sign up (s).'
end

def run_app

end

def login_or_signup
    user_input = gets.chomp.downcase
    case user_input
    when 'l'
        User.login
    when 's'   
        User.sign_up
    else
        system('clear')
        puts 'Invalid entry. Please try again.'
        welcome
        login_or_signup
    end
end



def menu
    puts 'Please select a number option below:'
    puts '1. Search for anime by title'
    puts '2. Look up review for anime'
    puts '3. Create a review'
    puts '4. Look up my reviews'
    puts '5. Update my reviews'
    puts '6. Delete my reviews'
    puts '7. Sign out'
end

def gets_anime
    puts 'What anime are you searching for?'
    anime = gets.chomp
    anime
end

def menu_selection(user)
    menu
    user_input = gets.chomp.to_i
    system('clear')
    case user_input
    when 1  
        anime = gets_anime
        Anime.search_anime(anime)
        menu_selection(user)
    when 2
        anime = gets_anime
        Anime.review(anime)
        menu_selection(user)
    when 3
        anime = gets_anime
        user.create_review(anime)
        menu_selection(user)
    when 4
        user.all_reviews
        menu_selection(user)
    when 5
        anime = gets_anime
        user.update_review(anime)
        menu_selection(user)
    when 6
        anime = gets_anime
        user.delete_review(anime)
        menu_selection(user)
    when 7
        puts 'Goodbye!'
    end
end
