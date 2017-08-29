class AddHasAccessToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_access, :boolean
  end
end
