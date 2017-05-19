class AddActiveToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :active, :boolean, default: true
    add_index :contacts, :active
  end
end
