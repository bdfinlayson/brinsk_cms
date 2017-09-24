module Api::V1
  class SessionsController < Api::BaseController
    skip_before_action :authenticate_user!

    def create
      binding.pry
    end
  end
end
