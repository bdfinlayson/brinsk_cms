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
      expect(page).to have_content(contact.first_name)
    end

    scenario 'should see a button to add a task' do
      click_link "#{contact.full_name}"
      expect(page).to have_content('Add Task')
    end

    let(:task) { FactoryGirl.build(:task) }

    scenario 'should create a task' do
      click_link "#{contact.full_name}"
      expect(page).to have_content('Add Task')
      create_task(task)
      expect(page).to have_content("Task created!")
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
    end

    scenario 'should not be able to edit a completed task' do
      click_link "#{contact.full_name}"
      expect(page).to have_button('Create Task')
      create_task(task)
      expect(page).to have_content("Task created!")
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      click_link 'Mark as Complete'
      expect(page).to_not have_link('Edit Task')
    end

    let(:other_task) { FactoryGirl.build(:task) }

    scenario 'should cancel a transaction' do
      click_link "#{contact.full_name}"
      create_task(task)
      expect(page).to have_content("Task created!")
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      within('div.task_list_wrapper') do
        click_link 'Edit Task'
      end
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      expect(page).to have_content('Add Task')
    end

    scenario 'should edit a task' do
      click_link "#{contact.full_name}"
      create_task(task)
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      within('div.task_list_wrapper') do
        click_link 'Edit Task'
      end
      edit_task(other_task)
      expect(page).to have_content('Task updated!')
      expect(page).to have_content(other_task.name)
      expect(page).to have_content(other_task.description)
    end

    scenario 'should delete a task' do
      click_link "#{contact.full_name}"
      create_task(task)
      expect(page).to have_content("Task created!")
      expect(page).to have_content(task.name)
      expect(page).to have_content(task.description)
      within('div.task_list_wrapper') do
        click_link 'Delete Task'
      end
      expect(page).to have_content("Task deleted!")
      expect(page).to_not have_content(other_task.name)
      expect(page).to_not have_content(other_task.description)
    end
  end
end
