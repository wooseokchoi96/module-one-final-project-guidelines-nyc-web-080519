require_relative '../config/environment'

welcome
puts 'Prompt message (login or signup)'
# puts "L for login or S for sign up"
# input = gets.chomp
current_user = User.login


#menu
puts 'this is a list of questions'

#picked to write review
puts 'What anime would you like to write a review for?'

user_input = gets.chomp
current_user.read_review(user_input)
# current_user.update_review(user_input)
#  current_user.create_review(user_input)





# ActiveRecord::Base.logger.level = 1    
# ActiveRecord::Base.logger.level = 0

binding.pry
puts "HELLO WORLD"
