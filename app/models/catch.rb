class Catch < ActiveRecord::Base
  scope :recent, -> { order 'caught_at DESC' }
  scope :top_5, -> { limit 5 }
  scope :top_10, -> { limit 10 }
  scope :for_competition, ->(competition) { where competition: competition }

  attr_reader :remote_image_url

  has_attached_file :image, styles: { medium_square: '300x300#',
                                      thumbnail: '60x60#' },
                            default_url: '/images/:style/missing.png'

  belongs_to :competition, inverse_of: 'catches', counter_cache: true
  belongs_to :user, inverse_of: 'catches', counter_cache: true

  validates :competition, presence: true
  validates :user, presence: true
  validates :bait_used, presence: true
  validates :location_description, presence: true
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates :length_in_inches,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_blank: true

  # Overidden
  def to_param
    "#{id} #{species}".parameterize
  end

  # see: https://github.com/thoughtbot/paperclip/wiki/Attachment-downloaded-from-a-URL
  def remote_image_url=(url_value)
    self.image = URI.parse url_value
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @remote_image_url = url_value
  end
end
