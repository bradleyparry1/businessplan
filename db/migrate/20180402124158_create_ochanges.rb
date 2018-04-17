class CreateOchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ochanges do |t|
      t.string :description
      t.integer :team_id
      t.integer :account_id
      t.string :supplier
      t.string :po_number
      t.float :apr, default: 0
      t.float :may, default: 0
      t.float :jun, default: 0
      t.float :jul, default: 0
      t.float :aug, default: 0
      t.float :sep, default: 0
      t.float :oct, default: 0
      t.float :nov, default: 0
      t.float :dec, default: 0
      t.float :jan, default: 0
      t.float :feb, default: 0
      t.float :mar, default: 0
      t.integer :other_id
      t.boolean :bmo_approved
      t.boolean :central_approved
      t.boolean :central_declined

      t.timestamps
    end
  end
end
