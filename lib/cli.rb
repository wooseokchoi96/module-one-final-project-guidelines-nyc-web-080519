require 'tty-prompt'
$prompt = TTY::Prompt.new

def welcome
    system('clear')
    message = <<-MSG
 _     _  _______  ___      _______  _______  __   __  _______    _______  _______              
| | _ | ||       ||   |    |       ||       ||  |_|  ||       |  |       ||       |             
| || || ||    ___||   |    |       ||   _   ||       ||    ___|  |_     _||   _   |             
|       ||   |___ |   |    |       ||  | |  ||       ||   |___     |   |  |  | |  |             
|       ||    ___||   |___ |      _||  |_|  ||       ||    ___|    |   |  |  |_|  |             
|   _   ||   |___ |       ||     |_ |       || ||_|| ||   |___     |   |  |       |             
|__| |__||_______||_______||_______||_______||_|   |_||_______|    |___|  |_______|             
 _______  __    _  ___   __   __  _______    _______  ___   __    _  ______   _______  ______   
|   _   ||  |  | ||   | |  |_|  ||       |  |       ||   | |  |  | ||      | |       ||    _ |  
|  |_|  ||   |_| ||   | |       ||    ___|  |    ___||   | |   |_| ||  _    ||    ___||   | ||  
|       ||       ||   | |       ||   |___   |   |___ |   | |       || | |   ||   |___ |   |_||_ 
|       ||  _    ||   | |       ||    ___|  |    ___||   | |  _    || |_|   ||    ___||    __  |
|   _   || | |   ||   | | ||_|| ||   |___   |   |    |   | | | |   ||       ||   |___ |   |  | |
|__| |__||_|  |__||___| |_|   |_||_______|  |___|    |___| |_|  |__||______| |_______||___|  |_|
                                                                                                
                                                                                                
                                                                                                
You can search for anime information and write reviews!                                                                                                   
                                                                                                
                                                                                                
                                                                                                 
    MSG
    puts message
end

def login_or_signup
    user_input = $prompt.select('Please login or sign up...', ['login', 'sign up'])
    case user_input
    when 'login'
        User.login
    when 'sign up'   
        User.sign_up
    end
end

def menu
    ['Search for anime by title',
     'Look up review for anime',
     'Create a review',
     'Look up my reviews',
     'Update my reviews',
     'Delete my reviews',
     'Sign out']
end

def gets_anime
    $prompt.ask('What anime are you searching for?')
end

def menu_selection(user)
    user_input = $prompt.select("\nPlease select a number option below:", menu)
    system('clear')
    case user_input
    when 'Search for anime by title'
        anime = gets_anime
        Anime.search_anime(anime)
        menu_selection(user)
    when 'Look up review for anime'
        anime = gets_anime
        Anime.review(anime)
        menu_selection(user)
    when 'Create a review'
        anime = gets_anime
        user.create_review(anime)
        menu_selection(user)
    when 'Look up my reviews'
        user.all_reviews
        menu_selection(user)
    when 'Update my reviews'
        anime = gets_anime
        user.update_review(anime)
        menu_selection(user)
    when 'Delete my reviews'
        anime = gets_anime
        user.delete_review(anime)
        menu_selection(user)
    when 'Sign out'
        puts 'GOODBYE!'
    end
end
