class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def index
    @search = Task.search do
      fulltext params[:search]
      order_by(:updated_at, :desc)
    end
    @tasks = @search.results

    # @tasks = Task.where('user_id = ?', current_user.id)
    @projects = Project.where('user_id = ?', current_user.id)
    @contacts = Contact.where('user_id = ?',  current_user.id)
  end

  def create
    params[:task][:user_id] = current_user.id
    @object = Contact.find(params[:contact_id]) unless params[:contact_id].nil?
    # @object = Project.find(params[:project_id]) unless params[:project_id].nil?
    @object = Stage.find(params[:stage_id]) unless params[:stage_id].nil?
    params[:task][:project_id] = @object.project_id unless params[:stage_id].nil?
    @task = @object.tasks.create(task_params)
    if @task.save
      if params[:contact_id] && params[:stage_id].nil?
        redirect_to contact_path(params[:contact_id]), notice: 'Task created!'
      elsif params[:stage_id]
        redirect_to project_path(params[:project_id]), notice: 'Task created!'
      else
        redirect_to root_path
        # redirect_to @object, notice: 'Unable to create task!'
      end
    else
      redirect_to root_path
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if params[:task].nil?
      @stage = Stage.find(@task.taskable_id)
      @available_stages = Stage.where('project_id = ?', @stage.project_id)
      @stages_ids = Array.new
      @available_stages.each do |stage|
        @stages_ids << stage.id
      end
      params[:task] = { taskable_id: params[:stage_id]  }
      if @task.update(task_params)
        redirect_to project_path(params[:project_id]), notice: "Task moved to stage #{params[:stage_id]}!"
      end
    else
      if @task.update(task_params)
        if @task.taskable_type == 'Contact'
          redirect_to contact_path(@task.taskable_id), notice: 'Task updated!'
        elsif @task.taskable_type == 'Stage'
          @stage = Stage.find(@task.taskable_id)
          redirect_to project_path(@stage.project_id), notice: 'Task updated!'
        else
          render 'edit', notice: 'Unable to update task!'
        end
      else
        render 'edit', notice: 'Unable to update task!'
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    if @task.taskable_type == 'Contact'
      redirect_to contact_path(@task.taskable_id), notice: 'Task deleted!'
    elsif @task.taskable_type == 'Stage'
      @stage = Stage.find(@task.taskable_id)
      redirect_to project_path(@stage.project_id), notice: 'Task deleted!'
    else
      redirect_to root_path
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update_attribute(:completed_at, Time.now)
    redirect_to :back, notice: 'Task completed!'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :project_id, :completed_at, :user_id, :taskable_id)
  end

end
