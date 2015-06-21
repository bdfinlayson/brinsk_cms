class AppointmentsController < ApplicationController

  def index
    @appointments = Appointment.all
  end

  def create
    @contact = Contact.find(params[:contact_id])
    params[:appointment][:user_id] = current_user.id
    @appointment = @contact.appointments.create(appointment_params)
    if @appointment.save
      redirect_to @contact, notice: 'Appointment created!'
    else
      redirect_to @contact, notice: 'Unable to create appointment!'
    end
  end

  private

  def appointment_params
    binding.pry
    params.require(:appointment).permit(:name, :starts_at, :user_id)
  end


end
