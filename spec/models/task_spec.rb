require 'spec_helper'

describe Task do

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.create(:contact, user_id: user.id) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id, contact_id: contact.id) }
  let(:stage) { FactoryGirl.create(:stage, project_id: project.id) }
  let(:task) { FactoryGirl.create(:task, taskable_id: contact.id, user_id: user.id) }

  subject { task }

  it { should respond_to(:taskable_id) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:due) }
  it { should respond_to(:completed_at) }


  it 'should create a new instance given valid attributes' do
    Task.create!(user_id: 1,
                    taskable_id: 10,
                    name: 'My Awesome Task',
                    description: 'This is a description of my task',
                    due: Time.now,
                   )
  end

  describe 'when name is not present' do
    before { task.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { task.name = 'a' * 51 }
    it { should_not be_valid }
  end

#   describe 'when due is not present' do
#     before { task.due = '' }
#     it { should_not be_valid }
#   end

#   describe 'when due date is in the past' do
#     before { task.due = 2.days.ago }
#     it { should_not be_valid }
#   end
end
