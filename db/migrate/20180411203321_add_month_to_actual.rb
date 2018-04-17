class AddMonthToActual < ActiveRecord::Migration[5.1]
  def change
    add_column :actuals, :month, :integer
  end
end
