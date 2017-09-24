module Api
  class BaseController < ::ApplicationController
    respond_to :json
    protect_from_forgery with: :null_session
  end
end
