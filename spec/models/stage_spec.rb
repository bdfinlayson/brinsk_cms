require 'spec_helper'

describe Stage do

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.create(:contact) }
  let(:project) { FactoryGirl.create(:project,
                                     user_id: user.id,
                                     contact_id: contact.id) }
  let(:stage) { FactoryGirl.create(:stage, project_id: project.id) }

  subject { stage }

  it { should respond_to(:project_id) }
  it { should respond_to(:name) }

  it 'should be valid with valid input' do
    Stage.create!(project_id: project.id, name: 'Stage 1')
  end

  describe 'when there is no name' do
    before { stage.project_id = '' }
    it { should_not be_valid }
  end

  describe 'when there is no project id' do
    before { stage.name = '' }
    it { should_not be_valid }
  end

end
