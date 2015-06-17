include ApplicationHelper

require 'pry'

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm Password', with: user.password
    click_button 'Create my account'
  end

