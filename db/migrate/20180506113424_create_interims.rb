class CreateInterims < ActiveRecord::Migration[5.1]
  def change
    create_table :interims do |t|
      t.string :name
      t.string :staff_number
      t.string :job_title
      t.integer :role_id
      t.integer :community_id
      t.integer :grade_id
      t.integer :profession_id
      t.integer :framework_id
      t.integer :status_id
      t.float :charge_rate

      t.timestamps
    end
  end
end
