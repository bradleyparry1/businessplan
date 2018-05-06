class CreateBaseOthers < ActiveRecord::Migration[5.1]
  def change
    create_table :base_others do |t|
      t.string :description
      t.integer :team_id
      t.integer :account_id
      t.string :supplier
      t.string :po_number
      t.float :apr
      t.float :may
      t.float :jun
      t.float :jul
      t.float :aug
      t.float :sep
      t.float :oct
      t.float :nov
      t.float :dec
      t.float :jan
      t.float :feb
      t.float :mar

      t.timestamps
    end
  end
end
