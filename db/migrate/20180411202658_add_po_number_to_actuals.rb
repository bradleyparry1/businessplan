class AddPoNumberToActuals < ActiveRecord::Migration[5.1]
  def change
    add_column :actuals, :po_number, :string
  end
end
