class User < ActiveRecord::Base
    has_many :reviews
    has_many :animes, through: :reviews

    def self.login
        puts 'Please login with your username and password.'
        puts 'Username: '
        username = gets.chomp.downcase
        puts 'Password: '
        password = gets.chomp
        if User.find_by(username: username) == nil 
            system("clear")
            puts 'Username was not found. Please try again.'
            login
        elsif User.find_by(username: username, password: password) == nil 
            system("clear")
            puts 'Invalid password. Please try again.'
            login
        else
            current_user = User.find_by(username: username)
            system("clear")
            puts "Welcome #{current_user.username}!"
            return current_user
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
    # if there is no review...
        id = Anime.find_or_create_anime_in_table(title).mal_id
        anime = Anime.find_by(mal_id: id)
        puts 'Please write your review for this anime: '
        review = gets.chomp
        puts 'Please provide a rating for this anime (1~10): '
        rating = gets.chomp.to_i
        Review.create(user_id: self.id, anime_id: anime.id, review: review, rating: rating, mal_id: id)
    end

    def update_review(title)
        anime = Anime.find_or_create_anime_in_table(title)
        my_review = self.reviews.select{|review| review.anime.name == anime.name}.first
        binding.pry
        if my_review.nil?
            puts 'You have not written a review for this anime yet.'
            # return them to the prompt
        else
            puts 'Please write your review for this anime: '
            review = gets.chomp
            puts 'Please provide a rating for this anime (1~10): '
            rating = gets.chomp.to_i
            my_review.update(review: review, rating: rating)
            binding.pry
        end
    end

    def read_review(title)
        id = Anime.find_or_create_anime_in_table(title).mal_id
        found = self.reviews.find_by(mal_id: id)
        if found.nil?
            puts 'You have not written a review for this anime yet.'
            #return to prompt
        else
            # puts "Your review for #{found.anime.name} is: "
            puts "Your review for #{found.anime.name} is: "
            puts '________________________________'
            puts "#{found.review}"
        end
    end

    def delete_review(title)
        id = Anime.find_or_create_anime_in_table(title).mal_id
        found = self.reviews.find_by(mal_id: id)
        if found.nil?
            puts 'You have not written a review for this anime yet.'
            #return to prompt
        else
            puts "Your review for #{found.anime.name} is: "
            puts '________________________________'
            puts "#{found.review}"
            puts 'Do you want to delete this review? (y or n)'
            user_input = gets.chomp.downcase
            if user_input == 'y' 
                puts 'Your review has been deleted.'
                found.delete
            else
                puts 'go back to prompt'
            end
        end
    end

    def all_reviews
        self.reviews.each do |review|
            puts "Your review for #{review.anime.name} is :"
            puts "#{review.review}"
            puts '_________________________________'
            sleep(1)
        end
    end

end