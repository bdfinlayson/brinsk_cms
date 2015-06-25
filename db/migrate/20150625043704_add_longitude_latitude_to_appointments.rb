class AddLongitudeLatitudeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :latitude, :float
    add_column :appointments, :longitude, :float
  end
end
