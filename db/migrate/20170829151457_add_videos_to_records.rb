class AddVideosToRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :videos, :json
  end
end
