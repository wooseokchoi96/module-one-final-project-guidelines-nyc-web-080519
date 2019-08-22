require 'tty-prompt'

class User < ActiveRecord::Base
    has_many :reviews
    has_many :animes, through: :reviews

    PROMPT = TTY::Prompt.new

    def self.login
        puts 'Please login with your username and password.'
        username = PROMPT.ask('Username: ')
        if User.find_by(username: username).nil? 
            system("clear")
            puts 'Username was not found.'
            user_input = PROMPT.select("Do you want to sign up?", %w(yes no))
            system('clear')
            case user_input
            when 'yes' 
                return self.sign_up
            when 'no' 
                login
            end
        end
        password = PROMPT.mask('Password: ')
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
        user_input = PROMPT.select('Do you need to reset your password?', %w(yes no))
        case user_input
        when 'yes'
            pin = PROMPT.mask('Please enter your pin: ').to_i
            username = PROMPT.ask('Reconfirm your username: ')
            if !User.find_by(username: username, pin: pin).nil?
                while true
                    puts "Your pin matches our record."
                    password1 = PROMPT.mask('Please enter a new password: ')
                    password2 = PROMPT.mask('Please reconfirm your password: ')
                    if password1 == password2
                        puts "Password has been updated."
                        User.update(username: username, pin: pin, password: password1)
                        system('clear')
                        break
                    else
                        puts "Passwords do not match. Please try again."
                    end
                end
            else
                puts "That username was wrong."
                self.forgot_password
            end
        when 'no'
            system('clear')
            login
        end
    end

    def self.sign_up
        puts 'Please sign up with username'
        user = PROMPT.ask('Username: ')
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
        pin = PROMPT.mask('Pin: ')
        pin2 = PROMPT.mask('Please reconfirm pin: ')
        unless pin == pin2
            puts "Pins do not match. Please try again"
            sleep(1)
            User.create_pin
        end
        pin
    end

    def self.create_password
        password = PROMPT.mask('Please enter a password: ')
        password2 = PROMPT.mask('Please reconfirm password: ')
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
            review = PROMPT.ask('Please write your review for this anime:')
            rating = PROMPT.ask('Please provide a rating for this anime (1~10):').to_i
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
            review = PROMPT.ask('Please write your review for this anime:')
            rating = PROMPT.ask('Please provide a rating for this anime (1~10):').to_i
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
            user_input = PROMPT.select('Do you want to delete this review?', %w(yes no))
            system('clear')
            if user_input == 'yes' 
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