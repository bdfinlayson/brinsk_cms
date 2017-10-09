module Api::V1
  class ContactsController < ::Api::BaseController
    def index
      render json: current_api_v1_user.contacts
    end
  end
end
