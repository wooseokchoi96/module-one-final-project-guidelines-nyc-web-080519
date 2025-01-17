require 'pry'
require 'tty-prompt'
require 'faker'

class Anime < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews

    PROMPT = TTY::Prompt.new

    def self.top_5_results(title)
        qry = Jikan::Query.new
        anime = qry.search(title, :anime)
        top_5_results = anime.result.take(5)
    end

    def self.find_anime_hash(title)
        top_5 = self.top_5_results(title)
        # binding.pry
        # puts 'These are the top five results. Please pick the corresponding number.'
        results = []
        top_5_titles = top_5.map{|anime| anime.title}.each.with_index(1){|anime, index| results << "#{index}. #{anime}"}
        # user_input = gets.chomp.to_i
        user_input = PROMPT.select('These are the top five results. Please pick one.', results).to_i
        anime_hash = top_5[user_input - 1].raw
        anime_hash
    end

    def self.find_or_create_anime_in_table(title)
        anime_hash = self.find_anime_hash(title)
        name = anime_hash["title"]
        synopsis = anime_hash["synopsis"]
        mal_id = anime_hash["mal_id"]
        Anime.find_or_create_by(name: name, synopsis: synopsis, mal_id: mal_id)
    end

    def self.search_anime(title)
        if self.find_by(name: title)
            anime = self.find_by(name: title)
            puts "Anime: #{anime.name}"
            puts "Synopsis: #{anime.synopsis}"
        else
            anime_create = self.find_or_create_anime_in_table(title)
            puts "Anime: #{anime_create.name}"
            puts "Synopsis: #{anime_create.synopsis}"
        end
    end

    def self.review(title)
        #add to reviews db as well, later
        if self.find_by(name: title)
            anime = self.find_by(name: title)
            anime_review = Review.where(anime_id: anime.id)
            rand_num = rand(0...anime_review.length)
            random_review = anime_review[rand_num]
            puts random_review.review
        else
            id = Anime.find_or_create_anime_in_table(title).mal_id
            all_reviews = RestClient.get("https://api.jikan.moe/v3/anime/#{id}/reviews")
            reviews_hash = JSON.parse(all_reviews)
            max_number = reviews_hash["reviews"].length
            random_review = rand(0...max_number)
            anime_info = reviews_hash["reviews"][random_review]
            reviewer = anime_info["reviewer"]["username"]
            review = anime_info["content"]
            review = "\n" + review.gsub('\\n', '').gsub("\r\n", "\r\n\n")
            rating = anime_info["reviewer"]["scores"]["overall"]
            user = User.find_or_create_by(username: reviewer)
            new_pass = Faker::Internet.password if user.password.nil?
            new_pin = rand(1000..9999) if user.pin.nil?
            user.update(password: new_pass, pin: new_pin)
            anime = Anime.find_by(mal_id: id)
            Review.find_or_create_by(user_id: user.id, anime_id: anime.id, review: review, rating: rating)
            puts review
        end
    end

end
