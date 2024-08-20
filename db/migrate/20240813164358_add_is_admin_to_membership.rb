class AddIsAdminToMembership < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :is_admin, :boolean, null: false , default: 0
  end
end
