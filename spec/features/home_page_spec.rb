require 'spec_helper'
require_relative '../support/utilities'

describe 'Dashboard' do
  subject { page }

  describe 'home page' do
    before { visit root_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end


end
