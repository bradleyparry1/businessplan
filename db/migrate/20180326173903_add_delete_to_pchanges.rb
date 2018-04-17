class AddDeleteToPchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :pchanges, :for_deletion, :boolean
  end
end
