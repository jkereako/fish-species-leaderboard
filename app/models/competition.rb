class Competition < ActiveRecord::Base
  scope :active, -> { where is_active: true }

  # Creates the method `winner` which is associated with the model `User` and
  # the column name `winner_id`. And so, `@competition.winner` returns a `User`
  # object.
  belongs_to :winner,
             inverse_of: 'victory',
             class_name: 'User',
             foreign_key: 'winner_id'

  # A catch must be associated with a competition. Each competition will have
  # the same catches.
  has_many :catches, inverse_of: 'competition'
  has_many :memberships, inverse_of: 'competition'
  has_many :users, through: 'memberships'

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :users

  # Overidden
  def to_param
    "#{id} #{name}".parameterize
  end
end
