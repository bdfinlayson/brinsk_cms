class StagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.find(params[:id])
    @contact = @project.contact_id
    @stage = Stage.new
  end

  def create
    params[:stage][:user_id] = current_user.id
    @project = Project.find(params[:project_id])
    params[:stage][:project_id] = @project.id
    @stage = @project.stages.create(stage_params)
    if @stage.save
      redirect_to @project, notice: 'Stage created!'
    else
      redirect_to @project
    end
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    @stage = Stage.find(params[:id])
    if @stage.update(stage_params)
      redirect_to project_path(@stage.project_id), notice: 'Stage updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @stage = Stage.find(params[:id])
    @stage.destroy
    redirect_to project_path(@stage.project_id), notice: 'Stage deleted!'
  end

  private

  def stage_params
    params.require(:stage).permit(:name, :user_id, :project_id)
  end

end
