class AddNameIdToPchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :pchanges, :name_id, :integer
  end
end
