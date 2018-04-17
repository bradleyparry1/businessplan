class AddForDeletionToOchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :ochanges, :for_deletion, :boolean
  end
end
