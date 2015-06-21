require 'spec_helper'

describe "Contacts page" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'contact creation' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }
    it { should have_link('New Contact') }

    let(:contact) { FactoryGirl.build(:contact) }
    let(:other_contact) { FactoryGirl.build(:contact) }

    scenario 'should be able to cancel a transation' do
      visit root_path
      click_link 'New Contact'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to_not have_link('Cancel')
      click_link 'New Contact'
      create_contact(contact)
      click_link 'Home'
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(page).to have_link('Cancel')
      click_link 'Cancel'
      expect(page).to_not have_link('Cancel')
      expect(page).to have_content(contact.first_name)
    end

    scenario 'should add contacts and view a list of contacts' do
      visit root_path
      expect(page).to have_content('0')
      expect(page).to_not have_content(contact.first_name)
      expect(page).to_not have_content(other_contact.first_name)
      click_link 'New Contact'
      expect(page).to have_content('First name')
      expect(page).to have_content('Last name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Company')
      expect(page).to have_content('Alt email')
      expect(page).to have_content('Phone')
      expect(page).to have_content('Title')
      expect(page).to have_content('First met')
      expect(page).to have_link('Cancel')
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.company_name)
      expect(page).to have_content(contact.alt_email)
      expect(page).to have_content(contact.phone)
      expect(page).to have_content(contact.title)
      click_link 'Home'
      expect(page).to have_content('1')
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'New Contact'
      expect(page).to have_content('First met')
      create_contact(other_contact)
      click_link 'Home'
      expect(page).to have_content('2')
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      expect(page).to have_content(other_contact.first_name)
      expect(page).to have_content(other_contact.last_name)
    end

    scenario 'should edit a contact' do
      visit root_path
      expect(page).to have_content('0')
      click_link 'New Contact'
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Home'
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
      click_link 'New Contact'
      create_contact(contact)
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Home'
      expect(page).to have_content(contact.first_name)
      expect(page).to have_content(contact.last_name)
      click_link 'Edit'
      click_link 'Delete'
      expect(page).to have_content('0')
    end
  end
end
