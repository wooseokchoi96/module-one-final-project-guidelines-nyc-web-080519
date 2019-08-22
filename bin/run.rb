require_relative '../config/environment'

ActiveRecord::Base.logger = nil

welcome
current_user = login_or_signup
menu_selection(current_user)

puts "--END OF PROGRAM--"
