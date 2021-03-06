class AddNameRoleReasonCatchesCountAndIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: '', null: false
    add_column :users, :role, :string, default: '', null: false
    add_column :users, :is_active, :boolean, default: true, null: false

    # Provide a reason for why the user was deactivated/inactivated.
    add_column :users, :reason, :string, default: '', null: false
    # Total times competed for all time
    add_column :users, :memberships_count, :integer, default: 0, null: false
    # Total catches for all time
    add_column :users, :catches_count, :integer, default: 0, null: false
  end
end
