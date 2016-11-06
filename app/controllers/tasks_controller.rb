class TasksController < ApplicationController
  def index
    @user = current_user.decorate
  end

  def edit

  end
end
