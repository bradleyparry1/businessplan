class CreateActuals < ActiveRecord::Migration[5.1]
  def change
    create_table :actuals do |t|
      t.integer :team_id
      t.integer :account_id
      t.integer :po_number
      t.text :description
      t.float :amount

      t.timestamps
    end
  end
end
