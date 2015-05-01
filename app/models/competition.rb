class Competition < ActiveRecord::Base
  has_many :users
  has_one :user, foreign_key: 'winner_id'

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :users
end
