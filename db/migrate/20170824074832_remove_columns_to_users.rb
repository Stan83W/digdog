class RemoveColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :discogs_username
    remove_column :users, :discogs_avatar
    remove_column :users, :token_expiry
    remove_column :users, :name
  end
end
