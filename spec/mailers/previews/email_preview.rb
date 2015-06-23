# Preview all emails at http://localhost:3000/rails/mailers/email
class EmailPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/email/email_contact.text.erb
  def email_contact.text.erb
    Email.email_contact.text.erb
  end

end
