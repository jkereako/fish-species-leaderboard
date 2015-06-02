include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :catch do
    # see: http://en.wikipedia.org/wiki/Creek_chubsucker
    species 'Chubsucker'
    bait_used 'Bologna'
    location_description 'Flax Pond'
    image do
      fixture_file_upload(Rails.root.join('spec/fixtures/pollock.jpg'), 'image/jpg')
    end
    caught_at DateTime.parse '2015-06-01 20:52:31 -0400'

    association :user, factory: 'competitor'
    association :competition
  end

end
