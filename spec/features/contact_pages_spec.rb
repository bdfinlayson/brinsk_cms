require 'spec_helper'

describe "Contacts page" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'contact creation' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }
    it { should have_link('Add Contact') }

    let(:contact) { FactoryGirl.build(:contact) }
    let(:other_contact) { FactoryGirl.build(:contact) }

    scenario 'should be able to cancel a transation' do
      visit root_path
      click_link 'Add Contact'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to_not have_link('Cancel')
      click_link 'Add Contact'
      create_contact(contact)
      within('nav') do
        click_link 'Contacts'
      end
      expect(page).to have_content('Edit')
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to have_link('Edit')
      expect(page).to have_content(contact.first_name)
    end

    scenario 'should add a contact' do
      visit root_path
      expect(page).to have_content('0')
      expect(page).to_not have_content(contact.first_name)
      expect(page).to_not have_content(other_contact.first_name)
      click_link 'Add Contact'
      expect(page).to have_content('First name')
      expect(page).to have_content('Last name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Company')
      expect(page).to have_content('Phone')
      expect(page).to have_content('Title')
      expect(page).to have_link('Cancel')
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.company_name)
      expect(page).to have_content(contact.phone)
      expect(page).to have_content(contact.title)
    end

    scenario 'should view a list of contacts' do
      create_contact(contact)
      visit root_path
      expect(page).to have_content('1')
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Add Contact'
      create_contact(other_contact)
      within('nav') do
        click_link 'Contacts'
      end
      expect(page).to have_content('2')
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      expect(page).to have_content(other_contact.first_name)
      expect(page).to have_content(other_contact.last_name)
    end

    scenario 'should edit a contact' do
      visit root_path
      expect(page).to have_content('0')
      click_link 'Add Contact'
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      within('nav') do
        click_link 'Contacts'
      end
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      edit_contact(other_contact)
      expect(page).to have_content('1')
      expect(page).to have_content(other_contact.first_name)
      expect(page).to have_content(other_contact.last_name)
    end

    scenario 'should destroy a contact' do
      visit root_path
      expect(page).to have_content('0')
      click_link 'Add Contact'
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      within('nav') do
        click_link 'Contacts'
      end
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Edit'
      click_link 'Delete'
      expect(page).to have_content('0')
    end

    let(:contact1) { FactoryGirl.build(:contact) }
    let(:contact2) { FactoryGirl.build(:contact) }
    let(:contact3) { FactoryGirl.build(:contact) }
    let(:contact4) { FactoryGirl.build(:contact) }
    let(:contact5) { FactoryGirl.build(:contact) }

    scenario 'should search and find the searched for contact by last name' do
      visit root_path
      expect(page).to have_content('0')
      create_contact(contact1)
      create_contact(contact2)
      create_contact(contact3)
      create_contact(contact4)
      create_contact(contact5)
      visit root_path
      expect(page).to have_content('5')
      within('.search-field') do
        fill_in 'search', with: "#{contact1.last_name}"
      end
      click_button 'Search'
      expect(page).to have_content(contact1.last_name)
      expect(page).to_not have_content(contact2.last_name)
      expect(page).to_not have_content(contact3.last_name)
      expect(page).to_not have_content(contact4.last_name)
      expect(page).to_not have_content(contact5.last_name)
    end

    scenario 'should search and find another searched for contact by first name' do
      visit root_path
      expect(page).to have_content('0')
      create_contact(contact1)
      create_contact(contact2)
      create_contact(contact3)
      create_contact(contact4)
      create_contact(contact5)
      visit root_path
      expect(page).to have_content('5')
      within('.search-field') do
        fill_in 'search', with: "#{contact5.first_name}"
      end
      click_button 'Search'
      expect(page).to_not have_content(contact1.first_name)
      expect(page).to_not have_content(contact2.first_name)
      expect(page).to_not have_content(contact3.first_name)
      expect(page).to_not have_content(contact4.first_name)
      expect(page).to have_content(contact5.first_name)
    end

    scenario 'should search and find another searched for contact by email' do
      visit root_path
      expect(page).to have_content('0')
      create_contact(contact1)
      create_contact(contact2)
      create_contact(contact3)
      create_contact(contact4)
      create_contact(contact5)
      visit root_path
      expect(page).to have_content('5')
      within('.search-field') do
        fill_in 'search', with: "#{contact2.email}"
      end
      click_button 'Search'
      expect(page).to_not have_content(contact1.email)
      expect(page).to have_content(contact2.email)
      expect(page).to_not have_content(contact3.email)
      expect(page).to_not have_content(contact4.email)
      expect(page).to_not have_content(contact5.email)
    end
  end
end
