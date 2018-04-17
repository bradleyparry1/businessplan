class AddDetailsToNames < ActiveRecord::Migration[5.1]
  def change
    add_column :names, :framework_id, :integer
    add_column :names, :status_id, :integer
    add_column :names, :charge_rate, :float
  end
end
