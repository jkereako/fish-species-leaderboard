class Catch < ActiveRecord::Base
  scope :recent, -> { order 'caught_at DESC' }

  belongs_to :user, inverse_of: 'catches', counter_cache: true

  # Overidden
  def to_param
    "#{id} #{species}".parameterize
  end
end
