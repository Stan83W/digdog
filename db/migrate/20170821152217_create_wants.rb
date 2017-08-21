class CreateWants < ActiveRecord::Migration[5.1]
  def change
    create_table :wants do |t|
      t.references :user, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps
    end
  end
end
