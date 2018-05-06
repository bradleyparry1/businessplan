class AddNameTypeToBasePeople < ActiveRecord::Migration[5.1]
  def change
    add_column :base_people, :name_type, :string
  end
end
