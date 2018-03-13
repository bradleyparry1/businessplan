class CreateProgrammes < ActiveRecord::Migration[5.1]
  def change
    create_table :programmes do |t|
      t.string :name

      t.timestamps
    end
  end
end
