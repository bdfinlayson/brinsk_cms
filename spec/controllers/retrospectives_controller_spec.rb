require 'rails_helper'

RSpec.describe RetrospectivesController, type: :controller do
  let(:contact) { FactoryGirl.create :contact, lead_team: true }

  describe "GET #new" do

    it "returns http success" do
      get :new, auth_token: contact.auth_token
      expect(response).to have_http_status(:success)
    end

    it 'redirects on failure' do
      contact.update lead_team: false

      get :new, auth_token: contact.auth_token
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to error_retrospectives_path
    end
  end

  describe "GET #create" do
    it "redirects to success page" do
      get :create, retrospective: { what_has_gone_well: 'bah', what_has_gone_poorly: 'asd', how_are_your_goals: 'asdgas'}, auth_token: contact.auth_token
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to thank_you_retrospectives_path
    end

    it 'redirects to error page' do
      contact.update lead_team: false
      get :create, retrospective: { what_has_gone_well: 'bah', what_has_gone_poorly: 'asd', how_are_your_goals: 'asdgas'}, auth_token: contact.auth_token
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to error_retrospectives_path
    end
  end

  describe "GET #index" do
    it "returns http success" do
    end
  end

end
