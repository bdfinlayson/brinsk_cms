require 'pry'

class AppointmentsController < ApplicationController

  def create
    @object = Contact.find(params[:contact_id]) if params[:contact_id]
    @object = Project.find(params[:project_id]) if params[:project_id]
    params[:appointment][:user_id] = current_user.id
    params[:appointment][:contact_id] = params[:contact_id] unless params[:contact_id].nil?
    params[:appointment][:contact_id] = @object.contact_id if @object.respond_to?(:contact_id)
    @appointment = @object.appointments.create(appointment_params)
    if @appointment.save
      redirect_to @object, notice: 'Appointment created!' if params[:project_id].nil?
      redirect_to @object, notice: 'Appointment created!' if params[:project_id]
    else
      redirect_to @object, notice: 'Unable to create appointment!' if params[:project_id].nil?
      redirect_to @object, notice: 'Unable to create appointment!' if params[:project_id]
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @project = Project.find(@appointment.appointable_id) if @appointment.appointable_type == 'Project'
    @contact = Contact.find(@appointment.appointable_id) if @appointment.appointable_type == 'Contact'
    if @contact.nil?
      @contact = Contact.find(@project.contact_id)
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to contact_path(@appointment.appointable_id), notice: 'Appointment updated!'
    else
      flash.nowi[:error] = 'Could not save appointment!'
      render 'edit'
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    if @appointment.appointable_type == 'Contact'
      redirect_to contact_path(@appointment.appointable_id), notice: 'Appointment deleted!'
    elsif @appointment.appointable_type == 'Project'
      @project = Project.find(@appointment.appointable_id)
      redirect_to project_path(@project), notice: 'Appointment deleted!'
    else
      redirect_to root_path
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:name, :starts_at, :user_id, :contact_id)
  end


end
