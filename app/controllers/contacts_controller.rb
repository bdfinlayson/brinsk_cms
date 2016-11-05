class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @contacts = current_user.contacts.all
    @search = Contact.search(params[:search])
    @contacts = @search.select { |contact| contact[:user_id] == current_user.id } unless @search.empty?
  end

  def show
    @contact = Contact.find(params[:id])
    @notes = @contact.notes.all
    @search = Note.search(params[:search])
    @notes = @search.select { |note| note[:contact_id] == @contact.id } unless @search.empty?
    @tasks = @contact.tasks.all
    @projects = @contact.projects.all
  end

  def email_contact
    @contact = Contact.find(params[:id])
    Email.email_contact(@contact, params[:name], params[:email]).deliver
    redirect_to @contact, :notice => 'Successfully sent a message!'
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
      redirect_to root_path, notice: 'Contact updated!'
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
    params.require(:contact).permit(:first_name, :last_name, :email, :company_name, :phone, :alt_email, :background, :street1, :title)
  end

end
