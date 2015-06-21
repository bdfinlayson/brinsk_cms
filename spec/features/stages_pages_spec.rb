require 'spec_helper'

describe 'Stages pages' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.build(:contact) }
  let(:project) { FactoryGirl.build(:project) }
  let(:task) { FactoryGirl.build(:task) }
  let(:stage) { FactoryGirl.build(:stage) }
  let(:other_stage) { FactoryGirl.build(:stage) }
  before { sign_in user }
  before { create_contact(contact) }

  describe 'stage creation in the project page' do
    before do
      visit root_path
      click_link 'Show'
      create_project(project)
      click_link 'Manage Project'
    end


    scenario 'should create a stage' do
      expect(page).to have_button('Create Stage')
      expect(page).to have_content(project.name)
      expect(project.stages.count).to eq(1)
    end

    scenario 'should not be able to edit a completed task' do
      expect(page).to have_button('Create Task')
      create_stage_task(task)
      expect(page).to have_content(task.name)
      click_link 'Mark as Complete'
      expect(page).to_not have_link('Edit task')
    end

    scenario 'should cancel a transaction' do
      create_stage(stage)
      expect(page).to have_content(stage.name)
      click_link 'Edit stage'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(stage.name)
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should edit a stage' do
      create_stage(stage)
      expect(page).to have_content(stage.name)
      click_link 'Edit stage'
      edit_stage(other_stage)
      expect(page).to have_content(other_stage.name)
    end

    scenario 'should delete a stage' do
      create_stage(stage)
      expect(page).to have_content(stage.name)
      expect(project.stages.count).to eq(1)
      click_link 'Delete'
      expect(page).to_not have_content(stage.name)
      expect(project.stages.count).to eq(0)
    end
  end
end
