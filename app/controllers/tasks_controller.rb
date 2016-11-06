class TasksController < ApplicationController
  def index
    @user = current_user.decorate
  end

  def edit

  end

  def create
    Task.create(task_params.merge(user: current_user))
    redirect_to tasks_path
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    render json: {}
  end

  private
    def task_params
      params.require(:task).permit(:state, :position, :name, :description)
    end
end
