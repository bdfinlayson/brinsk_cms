class TasksController < ApplicationController
  def index
    @user = current_user.decorate
    @tags = current_user.tags
    @task = Task.new
  end

  def edit
    @task = Task.find params[:id]
    @tags = current_user.tags
    render :edit, layout: false
  end

  def create
    @task = Task.create(task_params.merge(user: current_user))
    destroy_and_create_taggings
    redirect_to tasks_path
  end

  def update
    @task = Task.find(params[:id])
    destroy_and_create_taggings
    @task.update_attributes!(task_params)
    @task.save
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

  def destroy
    Task.find(params[:id]).destroy
    redirect_to tasks_path, notice: 'Task destroyed!'
  end

  private
    def task_params
      params.require(:task).permit(:state, :position, :name, :description, ids: [], positions: [])
    end

    def tag_params
      params.require(:task).permit(tags: [ids: []])
    end

    def destroy_and_create_taggings
      if tag_params[:tags][:ids].delete_if{|x| x.empty? }.any?
        @task.taggings.destroy_all
        Tag.where(id: tag_params[:tags][:ids]).each do |t|
          Tagging.create(taggable: @task, tag: t)
        end
      end
    end
end
