include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :catch do
    # see: http://en.wikipedia.org/wiki/Creek_chubsucker
    species 'Chubsucker'
    bait_used 'Bologna'
    location_description 'Flax Pond'
    image do
      fixture_file_upload(Rails.root.join('spec',
                                          'fixtures',
                                          'pollock.jpg'), 'image/jpg')
    end
    caught_at DateTime.parse '2015-06-01 20:52:31 -0400'

    # Associate the competition factory with this catch. This expression is
    # evaluated before the callbacks
    association :competition

    # Associate one of the 2 users of the competition with this catch.
    before :create do |a_catch|
      a_catch.user = a_catch.competition.users.first
    end

    after :build do |a_catch|
      a_catch.user = a_catch.competition.users.first
    end
  end
end
