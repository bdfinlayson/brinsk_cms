require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @contact = FactoryGirl.create(:contact)
  end


  subject { @contact }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:company_name) }
  it { should respond_to(:email) }
  it { should respond_to(:alt_email) }
  it { should respond_to(:phone) }
  it { should respond_to(:title) }
  it { should respond_to(:background) }
  it { should respond_to(:first_met) }

  it { should be_valid }

  describe 'when first name is not present' do
    before { @contact.first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when first name is too long' do
    before { @contact.first_name = 'a' * 16 }
    it { should_not be_valid }
  end

  describe 'when last name is not present' do
    before { @contact.last_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when last name is too long' do
    before { @contact.last_name = 'a' * 26 }
    it { should_not be_valid }
  end

end
