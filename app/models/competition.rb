class Competition < ActiveRecord::Base
  # Indicates the winner of the competition
  belongs_to :users

  # Indicates all of the users associated with this competiton
  has_and_belongs_to_many :users

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :users
end
