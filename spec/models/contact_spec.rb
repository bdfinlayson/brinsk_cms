require 'rails_helper'

describe Contact do
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
  it { should respond_to(:street1) }
  it { should respond_to(:street2) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:full_address) }


  it { should be_valid }

  it 'should create a new instance given valid attributes' do
    Contact.create!(first_name: 'Billy', last_name: 'Bones', email: 'billy@bones.com')
  end

  describe 'Update existing contact' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @contact = FactoryGirl.create(:contact, user: @user)
    end

    it 'should belong to a user' do
      expect(@contact.user_id).to eq(@user.id)
    end
  end

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

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[contact2foo,com contact_at_foo.org example,contact@foo. foo@bar_baz.com foo@bar+bax.com]
      addresses.each do |invalid_address|
        @contact.email = invalid_address
        expect(@contact).not_to be_valid
      end
    end
  end
end
