class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def email_contact
    @contact = Contact.find(params[:id])
    Email.email_contact(@contact, params[:name], params[:email]).deliver
    redirect_to @contact, :notice => 'Successfully sent a message!'
  end

  def index
    @projects = Project.where('user_id = ?', current_user)
    @search = Project.search(params[:search])
    @projects = @search.select { |project| project[:user_id] == current_user.id } unless @search.empty?
    @stages = Stage.where('user_id = ?', current_user)
    @tasks = Task.where('user_id = ?', current_user)
  end

  def show
    @project = Project.find(params[:id])
    @contact = Contact.find(@project.contact_id)
    @stages = @project.stages.all
    @note = Note.new
    @notes = Note.where('project_id = ?', @project.id)
    @search = Note.search(params[:search])
    @notes = @search.select { |note| note[:project_id] == @project.id } unless @search.empty?
  end

  def create
    params[:project][:user_id] = current_user.id
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
    params.require(:project).permit(:name, :description, :completed_at, :user_id)
  end

end
