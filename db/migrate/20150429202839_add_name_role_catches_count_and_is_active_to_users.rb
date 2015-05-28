class AddNameRoleCatchesCountAndIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: '', null: false
    add_column :users, :role, :string, default: '', null: false
    add_column :users, :is_active, :boolean, default: true, null: false
    # Total catches for all time
    add_column :users, :catches_count, :integer, default: 0, null: false
  end
end
