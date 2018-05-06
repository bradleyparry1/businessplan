class AddNameTypeToPchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :pchanges, :name_type, :string
  end
end
