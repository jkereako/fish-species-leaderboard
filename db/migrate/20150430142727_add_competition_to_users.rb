class AddCompetitionToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :competition, index: true, foreign_key: true
    add_column :users, :catches_count, :integer, default: 0, null: false
  end
end
