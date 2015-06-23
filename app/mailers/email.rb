class Email < ApplicationMailer
  default :from => "brinskcms2015@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.email.email_contact.text.erb.subject
  #
  def email_contact(contact, email_subject, email_body)

    @contact = contact
    @body = email_body
    mail :to => @contact.email, :subject => email_subject
  end
end
