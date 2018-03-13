class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :cc
      t.integer :group_id
      t.integer :programme_id

      t.timestamps
    end
  end
end
