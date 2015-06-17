class AddStreet1Street2CityStateZipcodeFullAddressToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :street1, :string
    add_column :contacts, :street2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :zipcode, :string
    add_column :contacts, :full_address, :string
  end
end
