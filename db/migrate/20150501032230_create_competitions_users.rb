class CreateCompetitionsUsers < ActiveRecord::Migration
  def change
    create_table :competitions_users do |t|
      # `belongs_to` is an alias of `references`
      t.belongs_to :competition, index: true, null: false
      t.belongs_to :user, index: true, null: false
    end
  end
end
