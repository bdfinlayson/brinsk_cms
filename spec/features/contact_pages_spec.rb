require 'spec_helper'

describe "Contacts page" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let!(:contact) { FactoryGirl.create(:contact, user_id: user.id) }

  describe 'contact creation' do
    before { visit root_path }

    it { should have_content('Contacts') }
    it { should have_title('Contacts') }
    it { should have_content('Add') }

    describe 'with invalid information' do

      it 'should not create a contact' do
        expect(page).to have_content('Contacts')
        expect { click_button 'Add'}.not_to change(Contact, :count)
      end
    end

    scenario 'should see a button to add a contact' do
      visit root_path
      expect(page).to have_content('Add')
    end

    scenario 'should view a list of contacts' do
      visit root_path
      expect(page).to have_content('1')
      expect(page).to have_content(contact.first_name)
    end
  end
end
