class ReportsController < ApplicationController
  def index
    @contacts = current_user.contacts.lead_team

  end

  def show

  end

  def create

  end
end
