require 'spec_helper'

describe "Notes" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_contact) { FactoryGirl.build(:contact) }
  let(:contact) { FactoryGirl.build(:contact) }
  before { sign_in user }
  before { create_contact(contact) }

  describe 'note creation in the contact page' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }

    it 'should have contacts to add notes to' do
      expect(page).to have_content('1')
    end

    scenario 'should see a button to add a note' do
      click_link 'Show'
      expect(page).to have_button('Create Note')
    end

    let(:note) { FactoryGirl.build(:note) }

    scenario 'should create a note' do
      click_link 'Show'
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
    end

    let(:other_note) { FactoryGirl.build(:note) }

    scenario 'should cancel a transaction' do
      click_link 'Show'
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should edit a note' do
      click_link 'Show'
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Edit'
      edit_note(other_note)
      expect(page).to have_content(other_note.subject)
      expect(page).to have_content(other_note.content)
    end

    scenario 'should delete a note' do
      click_link 'Show'
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Delete'
      expect(page).to_not have_content(other_note.subject)
      expect(page).to_not have_content(other_note.content)
    end
  end

  describe 'note creation in the project page' do

    let(:note) { FactoryGirl.build(:note) }
    let(:project) { FactoryGirl.build(:project) }

    before do
      visit root_path
      click_link 'Show'
      create_project(project)
      click_link 'Manage Project'
    end

    scenario 'should see a button to add a note' do
      expect(page).to have_button('Create Note')
    end

    scenario 'should create a note' do
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
    end

    let(:other_note) { FactoryGirl.build(:note) }

    scenario 'should edit a note' do
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Edit'
      edit_note(other_note)
      expect(page).to have_content(other_note.subject)
      expect(page).to have_content(other_note.content)
    end

    scenario 'should cancel a transaction' do
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      expect(page).to_not have_link('Cancel')
    end

    scenario 'should delete a note' do
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Delete'
      expect(page).to_not have_content(other_note.subject)
      expect(page).to_not have_content(other_note.content)
    end

    scenario 'should not see the project note in the contact page' do
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      click_link 'Back'
      expect(page).to_not have_content(note.subject)
      expect(page).to_not have_content(note.content)
    end
  end
end

