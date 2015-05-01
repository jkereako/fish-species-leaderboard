class Competition < ActiveRecord::Base
  # Creates the method `winner` which is associated with the model `User` and
  # the column name `winner_id`. And so, `@competition.winner` returns a `User`
  # object.
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'

  # A n:m association. Allows us to keep historical data
  has_and_belongs_to_many :competitors, class_name: 'User'

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :competitors
end
