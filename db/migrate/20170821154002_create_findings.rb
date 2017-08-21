class CreateFindings < ActiveRecord::Migration[5.1]
  def change
    create_table :findings do |t|
      t.references :record, foreign_key: true
      t.string :provider
      t.string :url

      t.timestamps
    end
  end
end
