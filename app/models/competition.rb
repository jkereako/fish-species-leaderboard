class Competition < ActiveRecord::Base
  # Active scopes
  scope :begun, -> { where('begins_at < ?', Time.zone.now) }

  # Inactive scopes
  scope :expired, -> { where has_expired: true }
  scope :suspended, -> { where is_suspended: true }
  scope :yet_to_begin, -> { where('begins_at > ?', Time.zone.now) }

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
  validates :users, length: { minimum: 2,
                             message: 'There must be at least 2 competitors' }
  validate :begins_at_is_not_in_the_past,
           unless: :skip_validate_begins_at_is_not_in_the_past,
           if: (proc do |c|
             c.begins_at.is_a?(Date) || c.begins_at.is_a?(Time)
           end)
  validate :ends_at_is_greater_than_begins_at,
           if: (proc do |c|
             (c.begins_at.is_a?(Date) || c.begins_at.is_a?(Time)) &&
               (c.ends_at.is_a?(Date) || c.ends_at.is_a?(Time))
           end)

  # Allows us to associate multiple User objects with 1 Competition object
  # when updating
  accepts_nested_attributes_for :users

  # Scope
  # Finds all on-going competitions
  def self.active
    where(has_expired: false, is_suspended: false)
      .where('begins_at < ?', Time.zone.now)
  end

  # Overidden
  def to_param
    "#{id} #{name}".parameterize
  end

  def active?
    !has_expired && !is_suspended && begins_at < Time.zone.now
  end

  def yet_to_begin?
    begins_at > Time.zone.now
  end

  def suspended?
    is_suspended
  end

  def expired?
    has_expired
  end

  private

  def begins_at_is_not_in_the_past
    return if begins_at.utc.to_date >= Time.now.utc.to_date
    errors.add(:begins_at, 'must be today or in the future')
  end

  def ends_at_is_greater_than_begins_at
    return if begins_at.utc.to_date < ends_at.utc.to_date
    errors.add(:ends_at, 'must be greater than beginning date')
  end
end
