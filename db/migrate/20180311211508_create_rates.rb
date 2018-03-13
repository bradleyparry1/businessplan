class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :group_id
      t.integer :grade_id
      t.float :salary

      t.timestamps
    end
  end
end
