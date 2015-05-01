class AddCatchesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :catches_count, :integer, default: 0, null: false
  end
end
