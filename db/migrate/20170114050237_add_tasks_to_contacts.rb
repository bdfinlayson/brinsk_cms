class AddTasksToContacts < ActiveRecord::Migration[5.0]
  def up
    User.find_each do |u|
      contacts = u.contacts
      contacts.find_each do |c|
        tags = u.tags.where(name: c.full_name)
        tags.each do |t|
          c.tags.push t
          c.save!
        end
      end
    end
  end
end
