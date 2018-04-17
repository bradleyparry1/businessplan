class CreatePchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :pchanges do |t|
      t.integer :person_id
      t.integer :team_id
      t.date :start
      t.date :end
      t.float :fte
      t.boolean :brexit
      t.boolean :bmo_approved
      t.boolean :central_approved

      t.timestamps
    end
  end
end
