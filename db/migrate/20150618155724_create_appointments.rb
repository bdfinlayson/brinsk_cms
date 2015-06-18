class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.datetime :date
      t.text :description
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :full_address
      t.references :appointable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
