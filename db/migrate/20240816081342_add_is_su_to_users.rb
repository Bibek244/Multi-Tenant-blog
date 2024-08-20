class AddIsSuToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_su, :boolean , default: false
  end
end
