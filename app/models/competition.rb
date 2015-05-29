class Competition < ActiveRecord::Base
  scope :active, -> { where is_active: true }

  attr_accessor :skip_validate_begins_at_is_not_in_the_past

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

  validates :name, presence: true, uniqueness: true
  validates :prize, presence: true
  validates :begins_at, presence: true
  validates :ends_at, presence: true
  validate :begins_at_is_not_in_the_past, unless: :skip_validate_begins_at_is_not_in_the_past
  validate :ends_at_is_greater_than_begins_at
  validates :users, presence: true

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :users

  # Overidden
  def to_param
    "#{id} #{name}".parameterize
  end

  def active?
    is_active
  end

  private

  def begins_at_is_not_in_the_past
    if Time.zone.today > begins_at
      errors.add(:begins_at, 'must be today or in the future')
    end
  end

  def ends_at_is_greater_than_begins_at
    if ends_at <= begins_at
      errors.add(:ends_at, 'must be greater than beginning date')
    end
  end
end
