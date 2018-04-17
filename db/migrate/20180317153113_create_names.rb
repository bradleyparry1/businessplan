class CreateNames < ActiveRecord::Migration[5.1]
  def change
    create_table :names do |t|
      t.string :name
      t.string :staff_number
      t.string :job_title
      t.integer :role_id
      t.integer :community_id
      t.integer :grade_id
      t.integer :profession_id

      t.timestamps
    end
  end
end
