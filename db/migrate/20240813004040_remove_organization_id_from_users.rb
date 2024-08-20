class RemoveOrganizationIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :organization_id, :integer
  end
end
