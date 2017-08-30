class AddColumnsToFindings < ActiveRecord::Migration[5.1]
  def change
    add_column :findings, :title, :string
    add_column :findings, :location, :string
    add_column :findings, :thumb, :string
    add_column :findings, :currency, :string
  end
end
