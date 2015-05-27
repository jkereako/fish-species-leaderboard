class Competition < ActiveRecord::Base
  scope :active, -> { where is_active: true }

  # Creates the method `winner` which is associated with the model `User` and
  # the column name `winner_id`. And so, `@competition.winner` returns a `User`
  # object.
  belongs_to :winner,
             inverse_of: 'victory',
             class_name: 'User',
             foreign_key: 'winner_id'

  # A n:m association. Allows us to keep historical data
  has_and_belongs_to_many :competitors,
                          inverse_of: 'competitions',
                          class_name: 'User',
                          counter_cache: true

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :competitors

  # Overidden
  def to_param
    "#{id} #{name}".parameterize
  end
end
