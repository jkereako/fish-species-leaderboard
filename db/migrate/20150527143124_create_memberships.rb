class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :competition, index: true, null: false
      t.belongs_to :user, index: true, null: false
      # Counter cache
      t.integer :competition_count, default: 0, null: false
      t.integer :users_count, default: 0, null: false
      t.timestamps null: false
    end
  end
end
