FactoryGirl.define do
  sequence(:name) { |n| "Species contest No. #{n}" }

  factory :competition do
    name { generate :name }
    prize 'All expenses paid trip to Haverhill'
    begins_at Time.zone.now
    ends_at Time.zone.tomorrow

    # The values in the transient block will be availble in the callbacks
    transient do
      competitor_count 2
    end

    before :create do |competition, _evaluator|
      competition.users << create(:competitor)
      competition.users << create(:competitor)
      # Although the code below was taken from the Getting Started guide, it
      # doesn't fucking work!
      # competition.users << create_list(:competitor,
      #                                  evaluator.competitor_count,
      #                                  competitions: [competition])
    end

    after :build do |competition, _evaluator|
      competition.users << build(:competitor)
      competition.users << build(:competitor)
    end
  end
end
