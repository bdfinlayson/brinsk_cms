class RetrospectivesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :thank_you, :error]
  before_action :find_contact, only: [:new, :create]

  def new
    @retrospective = Retrospective.new
  end

  def create
    Retrospective.create(retrospective_params)
    redirect_to thank_you_retrospectives_path
  end

  def index
  end

  def thank_you
  end

  def error
  end

    private
      def retrospective_params
        params.require(:retrospective).permit(:what_has_gone_well, :what_has_gone_poorly, :how_are_your_goals).merge(contact_id: @contact.id)
      end

      def find_contact
        @contact = Contact.find_by(auth_token: params[:auth_token])
        unless @contact && params[:auth_token].present?
          redirect_to error_retrospectives_path
        end
      end
end
