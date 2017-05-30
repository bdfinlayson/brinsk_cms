class UpdateTasksWithContacts < ActiveRecord::Migration[5.0]
  def up
    Tagging.find_each do |t|
      task = Task.unscoped.find_by id: t.taggable_id
      if task
        contact = Contact.unscoped.find_by(last_name: t.tag.name.split.last)
        task.update(contact: contact) if contact
      end
    end
  end
end
