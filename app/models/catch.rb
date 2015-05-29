class Catch < ActiveRecord::Base
  scope :recent, -> { order 'caught_at DESC' }
  scope :top_10, -> { limit 10 }

  belongs_to :competition, inverse_of: 'catches', counter_cache: true
  belongs_to :user, inverse_of: 'catches', counter_cache: true

  validates :competition, presence: true
  validates :user, presence: true
  validates :bait_used, presence: true
  validates :location_description, presence: true
  validates :length_in_inches,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_blank: true

  # Overidden
  def to_param
    "#{id} #{species}".parameterize
  end
end
