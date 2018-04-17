class AddCommentToPchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :pchanges, :comment, :text
  end
end
