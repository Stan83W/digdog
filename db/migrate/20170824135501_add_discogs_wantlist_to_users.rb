class AddDiscogsWantlistToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :discogs_wantlist, :json
  end
end
