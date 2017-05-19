class ContactsController < ApplicationController

  def index
    @user = current_user
    @contact = Contact.new
    if params[:lead_team]
      @contacts = current_user.contacts.lead_team.order(last_name: 'asc')
    elsif params[:inactive]
      @contacts = current_user.contacts.inactive.order(last_name: 'asc')
    else
      @contacts = current_user.contacts.active.order(last_name: 'asc')
    end
    @working_tasks = current_user.tasks.working
    @inbox_tasks = current_user.tasks.inbox
    @retros_for_week = Retrospective.where(contact_id: @contacts.lead_team.ids, created_at: Time.now.beginning_of_week..Time.now.end_of_week)
  end

  def show
    @contact = Contact.find(params[:id])
    @notes = Note.where(contact_id: @contact.id)
  end

  def send_status_update_request
    @contact = Contact.find(params[:id])
    if @contact.send_status_update_request
      redirect_to @contact, :notice => 'Emailed reminder'
    else
      redirect_to @contact, :alert => 'Unable to send email'
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = current_user
    @contact = @user.contacts.create(contact_params)
    if @contact.save
      redirect_to @contact, notice: 'Contact created!'
    else
      render 'new'
    end
  end

  def edit
    @contact = current_user.contacts.find(params[:id])
  end

  def update
    @contact = current_user.contacts.find(params[:id])

    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'Contact updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    redirect_to root_path, notice: 'Contact deleted!'
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :active, :lead_team, :email, :company_name, :phone, :alt_email, :background, :street1, :title)
  end

end
