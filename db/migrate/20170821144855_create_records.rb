class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.integer :discogs_id
      t.json :styles
      t.json :genres
      t.string :title
      t.json :artists
      t.json :labels
      t.integer :year
      t.string :thumb
      t.json :images
      t.string :discogs_uri

      t.timestamps
    end
  end
end
