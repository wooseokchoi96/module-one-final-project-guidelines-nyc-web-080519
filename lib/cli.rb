def welcome
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
    user_input = gets.chomp.to_i
    case user_input
    when 1
        anime = gets_anime
        Anime.search_anime(anime)
    when 2
        anime = gets_anime
        Anime.review(anime)
    when 3
        anime = gets_anime
        user.create_review(anime)
    when 4
        user.all_reviews
    when 5
        anime = gets_anime
        user.update_review(anime)
    when 6
        anime = gets_anime
        user.delete_review(anime)
    when 7
        Process.kill('INT', Process.pid)
    end
end
