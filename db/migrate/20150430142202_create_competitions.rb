class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      # Foreign key: the winner
      t.integer :winner_id, default: 0, null: false
      t.string :name, null: false, default: ''
      t.string :prize, null: false, default: ''
      t.datetime :begins_at, null: false
      t.datetime :ends_at, null: false
      t.boolean :is_active, null: false,  default: true
      # The number of catches the winner has
      t.integer :winner_catches_count, default: 0, null: false
      # Magic columns
      t.integer :users_count, default: 0, null: false
      # Total catches among all competitors
      t.integer :catches_count, default: 0, null: false
      t.timestamps null: false
    end
    add_index :competitions, :winner_id
    add_index :competitions, :name, unique: true
  end
end
