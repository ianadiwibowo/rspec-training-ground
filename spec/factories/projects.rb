FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}" }
    description 'Sample project for testing purposes'
    due_on 1.week.from_now
    association :owner

    trait :due_yesterday do
      due_on 1.day.ago
    end

    trait :due_today do
      due_on Date.current.in_time_zone
    end

    trait :due_tomorrow do
      due_on 1.day.from_now
    end

    trait :with_notes do
      after(:create) { |p| create_list(:note, 5, project: p) }
    end
  end
end
