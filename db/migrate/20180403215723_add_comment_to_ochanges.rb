class AddCommentToOchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :ochanges, :comment, :text
  end
end
