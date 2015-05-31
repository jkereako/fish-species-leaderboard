class Catch < ActiveRecord::Base
  scope :recent, -> { order 'caught_at DESC' }
  scope :top_10, -> { limit 10 }
  scope :for_competition, ->(competition) { where competition: competition }

  has_attached_file :image, styles: { medium: "300x300>",
                                       thumbnail: "100x100>" },
                            default_url: '/images/:style/missing.png'

  belongs_to :competition, inverse_of: 'catches', counter_cache: true
  belongs_to :user, inverse_of: 'catches', counter_cache: true

  validates :competition, presence: true
  validates :user, presence: true
  validates :bait_used, presence: true
  validates :location_description, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :length_in_inches,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_blank: true

  # Overidden
  def to_param
    "#{id} #{species}".parameterize
  end
end
