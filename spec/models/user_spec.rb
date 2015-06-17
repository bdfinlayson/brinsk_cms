require 'rails_helper'

ENV['RAILS_ENV'] = 'test'

describe User do
  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }

  it "#email returns a string" do
    @user.email = 'test@test.com'
    @user.update!(email: @user.email)
    expect(@user.email).to match 'test@test.com'
  end

  describe 'when first name is not present' do
    before { @user.first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when last name is not present' do
    before { @user.last_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { @user.password = ' ' }
    it { should_not be_valid }
  end

  describe 'when first name is too long' do
    before { @user.first_name = 'a' * 16 }
    it { should_not be_valid }
  end

  describe 'when last name is too long' do
    before { @user.last_name = 'a' * 26 }
    it { should_not be_valid }
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user2foo,com user_at_foo.org example,user@foo. foo@bar_baz.com foo@bar+bax.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end


  describe 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

end
