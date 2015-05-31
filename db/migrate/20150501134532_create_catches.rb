class CreateCatches < ActiveRecord::Migration
  def change
    create_table :catches do |t|
      #-- Foreign keys
      t.belongs_to :competition, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false

      t.string :species, null: false, default: ''
      t.integer :length_in_inches, null: false, default: 0
      t.string :bait_used, null: false, default: ''
      t.string :location_description, null: false, default: ''
      # This will serve as the base URL for the image associated with the catch.
      t.boolean :was_released, null: false,  default: true
      t.datetime :caught_at, null: false
      t.timestamps null: false
    end
    add_index :catches, :species
  end
end
