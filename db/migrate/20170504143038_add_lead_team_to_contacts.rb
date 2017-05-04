class AddLeadTeamToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :lead_team, :boolean
    add_index :contacts, :lead_team
  end
end
