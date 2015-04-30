class AddCompetitionToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :competition, index: true
    add_column :users, :catches_count, :integer, default: 0, null: false
    add_foreign_key :users, :competitions, on_delete: :cascade
  end
end
