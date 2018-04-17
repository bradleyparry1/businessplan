class RemovePoNumberFromActuals < ActiveRecord::Migration[5.1]
  def change
    remove_column :actuals, :po_number, :integer
  end
end
