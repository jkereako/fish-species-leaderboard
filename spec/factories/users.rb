FactoryGirl.define do
  factory :user do
    name 'Joey Jo-jo Jr. Shabadoo'
    password 'bippityboppity'

    trait :joeyjojos_email do
      email 'joeyjojo@moestavern.com'
    end

    trait :ricky_martins_email do
      email 'rickymartin@aol.com'
    end

    trait :admin_role do
      role 'administrator'
    end

    trait :user_role do
      role 'user'
    end

    factory :regular_user, traits: [:user_role, :joeyjojos_email]
    factory :other_regular_user, traits: [:user_role, :ricky_martins_email]
    factory :admin_user, traits: [:admin_role]
  end
end
