class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :discogs_id, :integer
    add_column :users, :discogs_wantlist_url, :string
    add_column :users, :discogs_username, :string
    add_column :users, :discogs_avatar, :string
    add_column :users, :discogs_uri, :string
    add_column :users, :phone_number, :integer
  end
end
