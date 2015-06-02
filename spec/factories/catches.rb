FactoryGirl.define do
  factory :catch do
    # see: http://en.wikipedia.org/wiki/Creek_chubsucker
    species 'Chubsucker'
    bait_used 'Bologna'
    caught_at DateTime.parse '2015-06-01 20:52:31 -0400'

    association :user, factory: :regular_user
    association :competition, factory: :future_competition
  end

end
# t.integer  "competition_id",                      null: false
# t.integer  "user_id",                             null: false
# t.string   "species",              default: "",   null: false
# t.integer  "length_in_inches",     default: 0,    null: false
# t.string   "bait_used",            default: "",   null: false
# t.string   "location_description", default: "",   null: false
# t.boolean  "was_released",         default: true, null: false
# t.datetime "caught_at",                           null: false
# t.datetime "created_at",                          null: false
# t.datetime "updated_at",                          null: false
# t.string   "image_file_name"
# t.string   "image_content_type"
# t.integer  "image_file_size"
# t.datetime "image_updated_at"
