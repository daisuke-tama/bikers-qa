FactoryBot.define do
  factory :message do
    content { "初めましてこんにちは" }
    association :user
    association :room
  end
end
