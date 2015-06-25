class AddLatitudLongitudeToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :latitude, :float
    add_column :contacts, :longitude, :float
  end
end
