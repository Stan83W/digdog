class AddPriceToFindings < ActiveRecord::Migration[5.1]
  def change
    add_column :findings, :price, :float
  end
end
