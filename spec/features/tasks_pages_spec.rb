require 'spec_helper'

describe 'Tasks' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_contact) { FactoryGirl.build(:contact) }
  let(:contact) { FactoryGirl.build(:contact) }
  before { sign_in user }
  before { create_contact(contact) }

  describe 'task creation in the contact page' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }

    it 'should have contacts to add tasks to' do
      expect(page).to have_content('1')
    end

    scenario 'should see a button to add a task' do
      click_link 'Show'
      expect(page).to have_button('Create Task')
    end

    let(:task) { FactoryGirl.build(:task) }

    scenario 'should create a task' do
      click_link 'Show'
      create_task(task)
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
    end

    let(:other_task) { FactoryGirl.build(:task) }

    scenario 'should cancel a transaction' do
      click_link 'Show'
      create_task(task)
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should edit a task' do
      click_link 'Show'
      create_task(task)
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      click_link 'Edit'
      edit_task(other_task)
      expect(page).to have_content(other_task.name)
      expect(page).to have_content(other_task.description)
    end

    scenario 'should delete a task' do
      click_link 'Show'
      create_task(task)
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      click_link 'Delete'
      expect(page).to_not have_content(other_task.name)
      expect(page).to_not have_content(other_task.description)
    end
  end
end
