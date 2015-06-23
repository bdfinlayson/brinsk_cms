class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    @contact = Contact.find(@project.contact_id)
    @stages = @project.stages.all
    @note = Note.new
    @notes = Note.where('project_id = ?', @project.id)
    @appointments = Appointment.where('appointable_id = ?', @project)
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @project = @contact.projects.create(project_params)
    if @project.save
      redirect_to @contact, notice: 'Project created!'
    else
      redirect_to @contact
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: 'Project updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to contact_path(@project.contact_id), notice: 'Project deleted!'
  end

  def complete
    @project = Project.find(params[:id])
    @project.update_attribute(:completed_at, Time.now)
    redirect_to :back, notice: 'Project completed!'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :completed_at)
  end

end
