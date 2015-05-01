class CreateCatches < ActiveRecord::Migration
  def change
    create_table :catches do |t|
      # Foreign key
      t.references :users, index: true, foreign_key: true
      t.string :species, null: false, default: ''
      t.integer :length_in_inches, null: false, default: 0
      t.string :bait_used, null: false, default: ''
      t.string :location_description, null: false, default: ''
      t.datetime :caught_at, null: false
      t.timestamps null: false
    end
    add_index :catches, :species
  end
end
