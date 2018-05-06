class AddNameTypeToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :name_type, :string
  end
end
