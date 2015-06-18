require 'spec_helper'

describe Appointment do

    let(:user) { FactoryGirl.create(:user) }
    let(:contact) { FactoryGirl.create(:contact, user_id: user.id) }
    let(:project) { FactoryGirl.create(:project,
                                     user_id: user.id,
                                     contact_id: contact.id) }
    let(:appointment) { FactoryGirl.create(:appointment,
                                           user_id: user.id) }


    subject { appointment }

    it { should respond_to(:user_id) }
    it { should respond_to(:date) }
    it { should respond_to(:description) }
    it { should respond_to(:street1) }
    it { should respond_to(:street2) }
    it { should respond_to(:city) }
    it { should respond_to(:state) }
    it { should respond_to(:zipcode) }
    it { should respond_to(:full_address) }
    it { should respond_to(:appointable_id) }
    it { should respond_to(:appointable_type) }

    it { should be_valid }

    it 'should create a new instance given valid attributes' do
      Appointment.create!(user_id: 1,
                          date: Time.now,
                          description: 'Lorem ipsum',
                          street1: '93 Chuckanutt Drive',
                          street2: 'Apt 101',
                          city: 'Oakland',
                          state: 'TN',
                          zipcode: '07430',
                          full_address: '93 Chuckanutt Drive, Apt 101, Oakland, TN 07430',
                          appointable_id: 20 )
    end



  describe 'when user id is not present' do
    before { appointment.user_id = '' }
    it { should_not be_valid }
  end

  describe 'when date is not present' do
    before { appointment.date = '' }
    it { should_not be_valid }
  end

  describe 'when description is not present' do
    before { appointment.description = '' }
    it { should be_valid }
  end

  describe 'when street1 is not present' do
    before { appointment.street1 = '' }
    it { should_not be_valid }
  end

  describe 'when street2 is not present' do
    before { appointment.street2 = '' }
    it { should be_valid }
  end

  describe 'when city is not present' do
    before { appointment.city = '' }
    it { should_not be_valid }
  end

  describe 'when state is not present' do
    before { appointment.state = '' }
    it { should_not be_valid }
  end

  describe 'when zipcode is not present' do
    before { appointment.zipcode = '' }
    it { should_not be_valid }
  end


  describe 'when all address info is entered' do
    before { Appointment.create!(user_id: 1,
                          date: Time.now,
                          description: 'Lorem ipsum',
                          street1: '93 Chuckanutt Drive',
                          street2: 'Apt 101',
                          city: 'Oakland',
                          state: 'TN',
                          zipcode: '07430',
                          full_address: '93 Chuckanutt Drive, Apt 101, Oakland, TN 07430',
                          appointable_id: 20 ) }
    let(:sample_appointment) { Appointment.first }

    it 'should generate the correct full address' do
      expect(sample_appointment.full_address).to eq("93 Chuckanutt Drive, Apt 101, Oakland, TN 07430")
    end
  end
end
