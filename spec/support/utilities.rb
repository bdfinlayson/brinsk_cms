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
    within('form#new_note') do
      fill_in 'Subject', with: note.subject
      fill_in 'Content', with: note.content
    end
    click_button 'Create Note'
  end

  def edit_note(note)
    fill_in 'Subject', with: note.subject
    fill_in 'Content', with: note.content
    click_button 'Update Note'
  end

  def create_task(task)
    within('form#new_task') do
      fill_in 'Name', with: task.name
      fill_in 'Description', with: task.description
    end
    click_button 'Create Task'
  end

  def edit_task(task)
    fill_in 'Name', with: task.name
    fill_in 'Description', with: task.description
    click_button 'Update Task'
  end

  def create_project(project)
    within('form#new_project') do
      fill_in 'Name', with: project.name
      fill_in 'Description', with: project.description
    end
    click_button 'Create Project'
  end

  def edit_project(project)
    fill_in 'Name', with: project.name
    fill_in 'Description', with: project.description
    click_button 'Update Project'
  end


  def create_stage(stage)
    within('form#new_stage') do
      fill_in 'Name', with: stage.name
    end
    click_button 'Create Stage'
  end

  def edit_stage(stage)
    fill_in 'Name', with: stage.name
    click_button 'Update Stage'
  end

  def create_stage_task(task, stage)
    within("div##{stage.name}") do
      within('form#new_task') do
        fill_in 'Name', with: task.name
        fill_in 'Description', with: task.description
        click_button 'Create Task'
      end
    end
  end

  def create_appointment(appointment)
    within("form#new_appointment") do
      fill_in 'Name', with: appointment.name
      click_button 'Create Appointment'
    end
  end


  def edit_appointment(appointment)
    fill_in 'Name', with: appointment.name
    click_button 'Update Appointment'
  end
