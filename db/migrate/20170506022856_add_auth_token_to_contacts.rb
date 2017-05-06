class AddAuthTokenToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :auth_token, :string
    add_index :contacts, :auth_token
  end
end
