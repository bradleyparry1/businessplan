class AddUserIdToOchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :ochanges, :user_id, :integer
  end
end
