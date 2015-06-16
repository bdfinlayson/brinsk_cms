require 'spec_helper'

describe 'Authentication' do

  subject { page }

  describe 'new user registration page' do
    before { visit new_user_registration_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end

  describe 'sign up' do
    before { visit new_user_registration_path }

    describe 'with invalid information' do
      before { click_button 'Sign up' }

      it { should have_title('Sign up') }
      it { should have_selector('div#error_explanation') }
    end
  end
end
