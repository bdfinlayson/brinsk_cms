require 'pry'

class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @note = Task.new
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @task = @contact.tasks.create(task_params)
    if @task.save
      redirect_to @contact, notice: 'Task created!'
    else
      redirect_to root_path
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to contact_path(@task.taskable_id), notice: 'Task updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to contact_path(@task.taskable_id), notice: 'Task deleted!'
  end

  def complete
    @task = Task.find(params[:id])
    @task.update_attribute(:completed_at, Time.now)
    redirect_to :back, notice: 'Task completed!'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :completed_at)
  end

end
