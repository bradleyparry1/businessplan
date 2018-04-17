class AddCentralDeclinedToPchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :pchanges, :central_declined, :boolean
  end
end
