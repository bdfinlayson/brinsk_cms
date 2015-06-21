require 'spec_helper'

describe Project do

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.create(:contact) }
  let(:project) { FactoryGirl.create(:project,
                                     user_id: user.id,
                                     contact_id: contact.id) }

  subject { project }

  it { should respond_to(:user_id) }
  it { should respond_to(:contact_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:completed_at) }


  it 'should create a new instance given valid attributes' do
    Project.create!(user_id: 1,
                    contact_id: 10,
                    name: 'My Awesome Project',
                    description: 'This is a description of my project',
                    start_date: Time.now,
                    end_date: Time.now,
                   )
  end

  describe 'when contact id is not present' do
    before { project.contact_id = '' }
    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before { project.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { project.name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when description is not present' do
    before { project.description = '' }
    it { should be_valid }
  end

  describe 'when start date is not present' do
    before { project.start_date = '' }
    it { should be_valid }
  end

  describe 'when end date is not present' do
    before { project.end_date = '' }
    it { should be_valid }
  end
end
