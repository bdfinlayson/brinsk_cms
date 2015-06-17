class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :email
      t.string :alt_email
      t.string :phone
      t.string :title
      t.text :background
      t.datetime :first_met

      t.timestamps null: false
    end
  end
end
