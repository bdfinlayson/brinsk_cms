require 'pry'
require 'spec_helper'
require 'database_cleaner'

require_relative '../support/utilities'

feature "Signing in" do
  background do
    User.create!(:first_name => 'Bryan', :last_name => 'Finlayson', :email => 'user@example.com', :password => 'caplin1234')
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    within("form#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'caplin1234'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end

  given(:other_user) { User.create(first_name: 'Joe', last_name: 'Shmoe', email: 'other@example.com', password: 'rous') }

  scenario "Signing in as another user" do
    visit 'users/sign_in'
    within("form#new_user") do
      fill_in 'Email', :with => other_user.email
      fill_in 'Password', :with => other_user.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password'
  end
end

describe 'Authentication' do

  subject { page }

  describe 'new user registration page' do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
    it { should have_content('First Name') }
    it { should have_content('Last Name') }
    it { should have_content('Email') }
    it { should have_content('Password') }
    it { should have_content('Confirm Password') }
  end

  describe 'creating a new account' do
    before { visit new_user_registration_path }

    describe 'with invalid information' do
      before { click_button 'Create my account' }

      it { should have_title('Sign up') }
      it { should have_selector('div#error_explanation') }
    end

    describe 'trying to visit a restricted page as user not logged in' do
      before { visit root_path }

      it { should have_title('Sign in') }
    end
  end
end
