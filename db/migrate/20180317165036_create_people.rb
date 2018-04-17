class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.integer :name_id
      t.integer :team_id
      t.date :start
      t.date :end
      t.float :fte
      t.boolean :brexit

      t.timestamps
    end
  end
end
