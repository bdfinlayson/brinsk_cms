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
      click_link "#{contact.full_name}"
      expect(page).to have_button('Create Note')
    end

    let(:note) { FactoryGirl.build(:note) }

    scenario 'should create a note' do
      click_link "#{contact.full_name}"
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
    end

    let(:other_note) { FactoryGirl.build(:note) }

    scenario 'should cancel a transaction' do
      click_link "#{contact.full_name}"
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      expect(page).to have_content('Note created!')
      within('div.note_container') do
        click_link 'Edit'
      end
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      expect(page).to have_button('Create Note')
    end

    scenario 'should edit a note' do
      click_link "#{contact.full_name}"
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      within('div.note_container') do
        click_link 'Edit'
      end
      edit_note(other_note)
      expect(page).to have_content(other_note.subject)
      expect(page).to have_content(other_note.content)
      expect(page).to have_content('Note updated!')
    end

    scenario 'should delete a note' do
      click_link "#{contact.full_name}"
      create_note(note)
      expect(page).to have_content(note.subject)
      expect(page).to have_content(note.content)
      within('div.note_container') do
        click_link 'Delete'
      end
      expect(page).to_not have_content(other_note.subject)
      expect(page).to_not have_content(other_note.content)
      expect(page).to have_content('Note deleted!')
    end

    let(:note1) { FactoryGirl.build(:note) }
    let(:note2) { FactoryGirl.build(:note) }
    let(:note3) { FactoryGirl.build(:note) }
    let(:note4) { FactoryGirl.build(:note) }

    scenario 'should search for a note' do
      click_link "#{contact.full_name}"
      create_note(note1)
      create_note(note2)
      create_note(note3)
      create_note(note4)
      within('.search-field') do
        fill_in 'search', with: "#{note1.subject}"
      end
      click_button 'Search'
      expect(page).to have_content(note1.subject)
      expect(page).to_not have_content(note2.subject)
      expect(page).to_not have_content(note3.subject)
      expect(page).to_not have_content(note4.subject)
    end

    scenario 'should search for a note content' do
      click_link "#{contact.full_name}"
      create_note(note1)
      create_note(note2)
      create_note(note3)
      create_note(note4)
      within('.search-field') do
        fill_in 'search', with: "#{note1.content}"
      end
      click_button 'Search'
      expect(page).to have_content(note1.content)
      expect(page).to_not have_content(note2.content)
      expect(page).to_not have_content(note3.content)
      expect(page).to_not have_content(note4.content)
    end
  end

  describe 'note creation in the project page' do

    let(:note) { FactoryGirl.build(:note) }
    let(:project) { FactoryGirl.build(:project) }

    before do
      visit root_path
      click_link "#{contact.full_name}"
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
      click_link "#{contact.full_name}"
      expect(page).to_not have_content(note.subject)
      expect(page).to_not have_content(note.content)
    end

    let(:note1) { FactoryGirl.build(:note) }
    let(:note2) { FactoryGirl.build(:note) }
    let(:note3) { FactoryGirl.build(:note) }
    let(:note4) { FactoryGirl.build(:note) }

    scenario 'should search for a note' do
      create_note(note1)
      create_note(note2)
      create_note(note3)
      create_note(note4)
      within('.search-field') do
        fill_in 'search', with: "#{note1.subject}"
      end
      click_button 'Search'
      expect(page).to have_content(note1.subject)
      expect(page).to_not have_content(note2.subject)
      expect(page).to_not have_content(note3.subject)
      expect(page).to_not have_content(note4.subject)
    end

    scenario 'should search for a note content' do
      create_note(note1)
      create_note(note2)
      create_note(note3)
      create_note(note4)
      within('.search-field') do
        fill_in 'search', with: "#{note1.content}"
      end
      click_button 'Search'
      expect(page).to have_content(note1.content)
      expect(page).to_not have_content(note2.content)
      expect(page).to_not have_content(note3.content)
      expect(page).to_not have_content(note4.content)
    end
  end
end

