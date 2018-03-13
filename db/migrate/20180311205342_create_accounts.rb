class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :code
      t.string :name
      t.string :major
      t.string :minor

      t.timestamps
    end
  end
end
