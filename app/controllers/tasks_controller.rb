class TasksController < ApplicationController
  def index
    @inbox_tasks = current_user.tasks.where(state: 'inbox')
    @working_tasks = current_user.tasks.where(state: 'working')
    @completed_tasks = current_user.tasks.where(state: 'completed')
    @archived_tasks = current_user.tasks.unscoped.where(state: 'archived').order(completed_at: :desc)
    @task = Task.new
    @contacts = current_user.contacts.active.order(last_name: :asc)
  end

  def edit
    @task = Task.find params[:id]
    @contacts = current_user.contacts.active.order(last_name: :asc)
    render :edit, layout: false
  end

  def create
    @task = Task.create(task_params.merge(user: current_user))
    redirect_to :back, notice: 'Task created'
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    @task.send(task_params[:state]) if task_params[:state].present?
    @task.save
    redirect_to :back, notice: 'Task updated'
  end

  def update_batch
    tasks = task_params[:ids].zip task_params[:positions]
    tasks.each do |task|
      t = Task.find task[0]
      t.update(position: task[1])
      t.send(task_params[:state])
    end
    render json: {}
  end

  def archive_batch
    tasks = task_params[:ids]
    tasks.each do |task_id|
      t = Task.find task_id
      t.archived
    end
    render json: {}
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to tasks_path, notice: 'Task destroyed!'
  end

  private
    def task_params
      params.require(:task).permit(:state, :position, :name, :description, :moved_task_id, :contact_id, ids: [], positions: [])
    end
end
