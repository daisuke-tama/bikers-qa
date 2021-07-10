FactoryBot.define do
  factory :article do
    association :user
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
