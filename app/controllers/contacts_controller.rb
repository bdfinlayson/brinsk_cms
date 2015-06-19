class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @contacts = current_user.contacts.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @user = current_user
    @contact = @user.contacts.create(contact_params)
    if @contact.save
      redirect_to @contact
    else
      render 'new'
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :company_name, :phone, :alt_email, :title)
  end

end
