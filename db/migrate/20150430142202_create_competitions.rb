class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name, null: false, default: ''
      t.string :prize, null: false, default: ''
      # Foreign key to `users`
      t.integer :winner_id
      t.datetime :begins_at, null: false
      t.datetime :ends_at, null: false

      # Magic columns
      t.integer :users_count, :integer, default: 0, null: false
      t.timestamps null: false
    end
    add_index :competitions, :winner_id
    add_index :competitions, :name, unique: true
  end
end
