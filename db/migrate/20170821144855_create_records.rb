class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.integer :discogs_id
      t.string :styles
      t.string :genres
      t.string :title
      t.string :artists
      t.string :labels
      t.integer :year
      t.string :discogs_uri

      t.timestamps
    end
  end
end
