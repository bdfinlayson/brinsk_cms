class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.0]
  def change
    ## Required
    add_column :users, :provider, :string, null: false, default: "email"
    add_column :users, :uid, :string, null: false, default: ""

    ## Tokens
    add_column :users, :tokens, :json

    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :string
    add_column :users, :confirmation_sent_at, :string
  end
end
