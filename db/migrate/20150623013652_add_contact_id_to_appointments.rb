class AddContactIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :contact_id, :integer
  end
end
