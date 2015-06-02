FactoryGirl.define do
  # Define each email field as a sequenced field
  sequence(:admin_email) { |n| "jon_snow#{n}@nightswatch.com" }
  sequence(:user_email) { |n| "grenn#{n}@nightswatch.com" }

  factory :user do
    password 'bippityboppity'

    trait :admin_role do
      email { generate :admin_email }
      name 'Lord Commander Jon Snow'
      role 'administrator'
    end

    trait :user_role do
      email { generate :user_email }
      name 'Grenn'
      role 'user'
    end

    # Use thusly:
    # ```sh
    # $ rails c test --sandbox
    # Loading test environment (Rails 4.2.1)
    # irb(main):001:0> FactoryGirl.create :competitor
    # (0.1ms)  begin transaction...
    # ```
    factory :regular_user, aliases: [:competitor], traits: [:user_role]

    factory :admin_user, aliases: [:admin], traits: [:admin_role]

  end
end
