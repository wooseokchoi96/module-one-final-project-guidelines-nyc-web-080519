require_relative '../config/environment'

ActiveRecord::Base.logger = nil

welcome
current_user = login_or_signup
menu
menu_selection(current_user)





# puts 'Prompt message (login or signup)'
# # puts "L for login or S for sign up"
# # input = gets.chomp
# current_user = User.login


# #menu
# puts 'this is a list of questions'

# #picked to write review
# puts 'What anime would you like to see'

# user_input = gets.chomp
# current_user.read_review(user_input)
# # current_user.delete_review(user_input)
# # current_user.update_review(user_input)
# #  current_user.create_review(user_input)

# Anime.chosen_result(user_input)

# binding.pry
puts "END OF PROGRAM"
