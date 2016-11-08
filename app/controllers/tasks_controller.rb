class TasksController < ApplicationController
  def index
    @user = current_user.decorate
  end

  def edit
    @task = Task.find params[:id]
    render :edit, layout: false
  end

  def create
    Task.create(task_params.merge(user: current_user))
    redirect_to tasks_path
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    redirect_to tasks_path
  end

  def update_batch
    tasks = task_params[:ids].zip task_params[:positions]
    tasks.each do |task|
      t = Task.find task[0]
      t.update(position: task[1], state: task_params[:state])
    end
    render json: {}
  end

  private
    def task_params
      params.require(:task).permit(:state, :position, :name, :description, ids: [], positions: [])
    end
end
