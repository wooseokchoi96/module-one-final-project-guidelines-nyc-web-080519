class User < ActiveRecord::Base
    has_many :reviews
    has_many :animes, through: :reviews

    def self.login
        puts 'Please login with your username and password.'
        puts 'Username: '
        username = gets.chomp.downcase
        if User.find_by(username: username).nil? 
            system("clear")
            puts 'Username was not found.'
            puts "Do you want to sign up? (y or n)"
            user_input = gets.chomp
            system('clear')
            case user_input
            when 'y' 
                return self.sign_up
            when 'n' 
                login
            else
                puts 'Invalid entry. Please try again.'
                login
            end
        end
        puts 'Password: '
        password = gets.chomp
        if User.find_by(username: username, password: password).nil? 
            system("clear")
            puts 'Invalid password.'
            self.forgot_password
        else
            current_user = User.find_by(username: username)
            system("clear")
            puts "Welcome #{current_user.username}!"
            return current_user
        end
    end

    def self.forgot_password
        puts 'Do you need to reset your password? (y or n)'
        user_input = gets.chomp
        case user_input
        when 'y'
            puts "Please enter your pin: "
            pin = gets.chomp.to_i
            puts "Reconfirm your username: "
            username = gets.chomp
            if !User.find_by(username: username, pin: pin).nil?
                while true
                    puts "Your pin matches our record."
                    puts "Please enter a new password: "
                    password1 = gets.chomp
                    puts "Please reconfirm your password: "
                    password2 = gets.chomp
                    if password1 == password2
                        puts "Password has been updated."
                        User.update(username: username, pin: pin, password: password1)
                        break
                    else
                        puts "Passwords do not match. Please try again."
                    end
                end
            else
                puts "That username was wrong."
                self.forgot_password
            end
        when 'n'
            system('clear')
            login
        else
            system('clear')
            puts "Invalid entry. Please try again."
            self.forgot_password
        end
    end

    def self.sign_up
        puts 'Please sign up with username'
        puts 'Username: '
        user = gets.chomp.downcase
        if User.find_by(username: user)
            system("clear")
            puts 'Sorry that username is already taken.'
            User.sign_up
        else
            pw = User.create_password
            pin = User.create_pin
            User.create(username: user, password: pw, pin: pin)
            system("clear")
            puts "Account Setup Complete!"
            current_user = User.find_by(username: user)
            puts "Welcome #{user}!"
            return current_user
        end
        
    end

    def self.create_pin
        puts "Passwords match! Please enter a pin# for account retrieval"
        puts "Pin: "
        pin = gets.chomp.to_i
        puts "Please reconfirm pin"
        puts "Pin: "
        pin2 = gets.chomp.to_i
        unless pin == pin2
            puts "Pins do not match. Please try again"
            sleep(1)
            User.create_pin
        end
        pin
    end

    def self.create_password
        puts 'Please enter a password'
        puts 'Password: '
        password = gets.chomp
        puts 'Please reconfirm password'
        password2 = gets.chomp
        unless password == password2
            puts "Passwords do not match. Please try again"
            sleep(1)
            User.create_password
        end
        password
    end

    def create_review(title)
        id = Anime.find_or_create_anime_in_table(title).mal_id
        if !Review.find_by(user_id: self.id, mal_id: id).nil?
            system('clear')
            puts 'You already have a review for this anime.'
            menu_selection(current_user)
        else
            anime = Anime.find_by(mal_id: id)
            puts 'Please write your review for this anime: '
            review = gets.chomp
            puts 'Please provide a rating for this anime (1~10): '
            rating = gets.chomp.to_i
            user_review = Review.create(user_id: self.id, anime_id: anime.id, review: review, rating: rating, mal_id: id)
            system('clear')
            puts "You created a review for #{user_review.anime.name} as:"
            puts user_review.review
        end
    end

    def update_review(title)
        anime = Anime.find_or_create_anime_in_table(title)
        my_review = self.reviews.select{|review| review.anime.name == anime.name}.first
        if my_review.nil?
            system('clear')
            puts 'You have not written a review for this anime yet.'
            menu_selection(current_user)
        else
            puts 'Please write your review for this anime: '
            review = gets.chomp
            puts 'Please provide a rating for this anime (1~10): '
            rating = gets.chomp.to_i
            my_review.update(review: review, rating: rating)
            system('clear')
            puts "You updated a review for #{my_review.anime.name} as: "
            puts my_review.review
        end
    end

    def read_review(title)
        id = Anime.find_or_create_anime_in_table(title).mal_id
        found = self.reviews.find_by(mal_id: id)
        if found.nil?
            system('clear')
            puts 'You have not written a review for this anime yet.'
            menu_selection(current_user)
        else
            system('clear')
            puts "Your review for #{found.anime.name} is: "
            puts '============================================='
            puts "#{found.review}"
        end
    end

    def delete_review(title)
        id = Anime.find_or_create_anime_in_table(title).mal_id
        found = self.reviews.find_by(mal_id: id)
        if found.nil?
            system('clear')
            puts 'You have not written a review for this anime yet.'
            menu_selection(self)
        else
            system('clear')
            puts "Your review for #{found.anime.name} is: "
            puts '============================================'
            puts "#{found.review}"
            puts 'Do you want to delete this review? (y or n)'
            user_input = gets.chomp.downcase
            system('clear')
            if user_input == 'y' 
                puts 'Your review has been deleted.'
                found.delete
            else
                puts 'Canceled.'
                menu_selection(self)
            end
        end
    end

    def all_reviews
        system('clear')
        self.reviews.each do |review|
            puts "Your review for #{review.anime.name} is :"
            puts "#{review.review}"
            puts '_________________________________'
            sleep(1)
        end
    end

end