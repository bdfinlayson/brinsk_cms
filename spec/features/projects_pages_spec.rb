require 'spec_helper'

describe 'Projects' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_contact) { FactoryGirl.build(:contact) }
  let(:contact) { FactoryGirl.build(:contact) }
  let(:project) { FactoryGirl.build(:project) }
  let(:other_project) { FactoryGirl.build(:project) }
  before { sign_in user }
  before { create_contact(contact) }

  describe 'index page for projects' do

    before {
      visit root_path
      click_link "#{contact.full_name}"
      create_project(project)
      create_project(other_project)
      within('nav') do
        click_link 'Projects'
      end
    }

    it { should have_content('Projects (2)') }
    it { should have_content(project.name) }
    it { should have_content(other_project.name) }


    scenario 'should search and find the searched for project by name' do
      expect(page).to have_content('Projects (2)')
      within('.search-field') do
        fill_in 'search', with: "#{project.name}"
      end
      click_button 'Search'
      expect(page).to have_content('Projects (1)')
      expect(page).to have_content(project.name)
      expect(page).to_not have_content(other_project.name)
    end

    scenario 'should search and find the searched for project by description' do
      expect(page).to have_content('Projects (2)')
      within('.search-field') do
        fill_in 'search', with: "#{project.description}"
      end
      click_button 'Search'
      expect(page).to have_content('Projects (1)')
      expect(page).to have_content(project.name)
      expect(page).to_not have_content(other_project.name)
    end

    scenario 'should search and not find an invalid search parameter' do
      expect(page).to have_content('Projects (2)')
      within('.search-field') do
        fill_in 'search', with: "#{contact.last_name}"
      end
      click_button 'Search'
      expect(page).to have_content('Projects (2)')
      expect(page).to have_content(project.name)
      expect(page).to have_content(other_project.name)
    end
  end

  describe 'project creation in the contact page' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }

    it 'should have contacts to add projects to' do
      expect(page).to have_content('1')
      expect(page).to have_content(contact.first_name)
    end

    scenario 'should see a button to add a project' do
      click_link "#{contact.full_name}"
      expect(page).to have_button('Create Project')
    end

    let(:project) { FactoryGirl.build(:project) }

    scenario 'should create a project' do
      click_link "#{contact.full_name}"
      expect(page).to have_button('Create Project')
      create_project(project)
      expect(page).to have_content(project.name)
    end

    scenario 'should not be able to manage a completed project' do
      click_link "#{contact.full_name}"
      expect(page).to have_button('Create Project')
      create_project(project)
      expect(page).to have_content(project.name)
      click_link 'Mark as Complete'
      expect(page).to_not have_link('Manage project')
    end

    let(:other_project) { FactoryGirl.build(:project) }

    scenario 'should cancel a transaction' do
      click_link "#{contact.full_name}"
      create_project(project)
      expect(page).to have_content(project.name)
      click_link 'Manage Project'
      click_link 'Edit project'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(project.name)
      expect(page).to have_content(project.description)
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should manage a project' do
      click_link "#{contact.full_name}"
      create_project(project)
      expect(page).to have_content(project.name)
      click_link 'Manage Project'
      expect(page).to have_content(project.name)
      expect(page).to have_content(project.description)
    end

    scenario 'should delete a project' do
      click_link "#{contact.full_name}"
      create_project(project)
      expect(page).to have_content(project.name)
      click_link 'Delete'
      expect(page).to_not have_content(other_project.name)
      expect(page).to_not have_content(other_project.description)
    end
  end
end
