FactoryGirl.define do
  factory :competition do
    name 'Species contest 2015'
    prize 'All expenses paid trip to Haverhill'

    trait :past_competition do
      begins_at DateTime.parse '2010-01-01 00:00:00 -0400'
      ends_at DateTime.parse '2010-06-30 23:59:59 -0400'
    end

    trait :present_competition do
      begins_at DateTime.parse '2015-06-01 00:00:00 -0400'
      ends_at DateTime.parse '2015-12-31 23:59:59 -0400'
    end

    trait :future_competition do
      begins_at DateTime.parse '2020-01-01 00:00:00 -0400'
      ends_at DateTime.parse '2020-06-30 23:59:59 -0400'
    end

    factory :past_competition, traits: [:past_competition]
    factory :present_competition, traits: [:present_competition]
    factory :future_competition, traits: [:future_competition]

    association :user, factory: :regular_user
  end
end
# t.integer  "winner_id",            default: 0,     null: false
# t.string   "name",                 default: "",    null: false
# t.string   "prize",                default: "",    null: false
# t.datetime "begins_at",                            null: false
# t.datetime "ends_at",                              null: false
# t.boolean  "has_expired",          default: false, null: false
# t.boolean  "is_suspended",         default: false, null: false
# t.integer  "winner_catches_count", default: 0,     null: false
# t.integer  "users_count",          default: 0,     null: false
# t.integer  "catches_count",        default: 0,     null: false
# t.datetime "created_at",                           null: false
# t.datetime "updated_at",                           null: false
