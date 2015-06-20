include ApplicationHelper

require 'pry'

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm Password', with: user.password
    click_button 'Create my account'
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end

  def create_contact(contact)
    visit new_contact_path
    fill_in 'First name', with: contact.first_name
    fill_in 'Last name', with: contact.last_name
    fill_in 'Email', with: contact.email
    fill_in 'Company', with: contact.company_name
    fill_in 'Alt email', with: contact.alt_email
    fill_in 'Phone', with: contact.phone
    fill_in 'Title', with: contact.title
    fill_in 'Background', with: contact.background
    # fill_in 'First met', with: contact.first_met
    click_button 'Create Contact'
  end

  def edit_contact(contact)
    fill_in 'First name', with: contact.first_name
    fill_in 'Last name', with: contact.last_name
    click_button 'Update Contact'
  end

  def create_note(note)
    fill_in 'Subject', with: note.subject
    fill_in 'Content', with: note.content
    click_button 'Create Note'
  end

  def edit_note(note)
    fill_in 'Subject', with: note.subject
    fill_in 'Content', with: note.content
    click_button 'Update Note'
  end
