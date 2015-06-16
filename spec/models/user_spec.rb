require 'rails_helper'

ENV['RAILS_ENV'] = 'test'

describe User do
  before(:each) { @user = User.new(first_name: 'Bryan',
                                   last_name: 'Finlayson',
                                   email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end
end
