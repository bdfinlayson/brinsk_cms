class DropTableAppointments < ActiveRecord::Migration[5.0]
  def change
    drop_table :appointments
  end
end
