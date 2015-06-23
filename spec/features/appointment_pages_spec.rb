require 'spec_helper'

describe 'Appointments' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:contact) { FactoryGirl.build(:contact) }
  let(:other_contact) { FactoryGirl.build(:contact) }
  let(:appointment) { FactoryGirl.build(:appointment) }
  let(:other_appointment) { FactoryGirl.build(:appointment) }
  let(:project) { FactoryGirl.build(:project) }

  before { sign_in user }
  before { create_contact(contact) }

  describe 'appointment creation in the contact profile page' do
    before do
      visit root_path
      click_link 'Show'
      create_appointment(appointment)
    end

    it 'should see a button to add an appointment' do
      expect(page).to have_button('Create Appointment')
    end

    scenario 'should be unable to create an appointment with invalid info' do
      click_button 'Create Appointment'
      expect(page).to have_css('p.notice')
    end

    scenario 'should cancel a transaction' do
      first(:link, appointment.name).click
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should edit a appointment' do
      first(:link, appointment.name).click
      click_link 'Edit'
      edit_appointment(other_appointment)
      expect(page).to have_content(other_appointment.name)
    end

    scenario 'should delete a appointment' do
      first(:link, appointment.name).click
      click_link 'Delete'
      expect(page).to_not have_content(appointment.name)
    end
  end

  describe 'appointment creation in the project page' do
    before do
      visit root_path
      click_link 'Show'
      create_project(project)
      click_link 'Manage Project'
      create_appointment(appointment)
    end

    it 'should see a button to add another appointment' do
      expect(page).to have_button('Create Appointment')
    end

    scenario 'should be unable to create an appointment with invalid info' do
      click_button 'Create Appointment'
      expect(page).to have_css('p.notice')
    end

    scenario 'should cancel a transaction' do
      first(:link, appointment.name).click
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should edit a appointment' do
      first(:link, appointment.name).click
      click_link 'Edit'
      edit_appointment(other_appointment)
      expect(page).to have_content(other_appointment.name)
    end

    scenario 'should delete a appointment' do
      first(:link, appointment.name).click
      click_link 'Delete'
      expect(page).to_not have_content(appointment.name)
    end

    scenario 'should see a project appointment in the contact profile page' do
      click_link 'Back'
      expect(page).to have_content(appointment.name)
    end

    scenario 'should delete a project and no longer see the appointments in the contact page' do
      click_link 'Back'
      click_link 'Delete Project'
      expect(page).to_not have_content(appointment.name)
    end

    scenario 'should delete a contact and no longer see the appointments for the contact in the home page' do
      click_link 'Back'
      click_link 'Home'
      click_link 'Edit'
      click_link 'Delete'
      expect(page).to_not have_content(appointment.name)
    end
  end
end
