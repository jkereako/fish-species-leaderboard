class Catch < ActiveRecord::Base
  scope :recent, -> { order 'caught_at DESC' }

  belongs_to :competition, inverse_of: 'catches', counter_cache: true
  belongs_to :user, inverse_of: 'catches', counter_cache: true

  validates :competition, presence: true
  validates :user, presence: true
  validates :bait_used, presence: true
  validates :location_description, presence: true
  validates :length_in_inches,
            presence: true,
            numericality: { only_integer: true },
            allow_blank: true

  # Overidden
  def to_param
    "#{id} #{species}".parameterize
  end
end

# t.integer  "competition_id",                    null: false
# t.integer  "user_id",                           null: false
# t.string   "species",              default: "", null: false
# t.integer  "length_in_inches",     default: 0,  null: false
# t.string   "bait_used",            default: "", null: false
# t.string   "location_description", default: "", null: false
# t.datetime "caught_at",                         null: false
