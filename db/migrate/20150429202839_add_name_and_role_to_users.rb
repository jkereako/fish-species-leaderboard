class AddNameAndRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: '', null: false
    add_column :users, :role, :string, default: '', null: false
  end
end
