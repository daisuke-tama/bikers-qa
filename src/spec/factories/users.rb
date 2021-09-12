FactoryBot.define do
  factory :user do
    name { "Alice" }
    introduce { "aliceとbob" }
    sequence(:email) { |n| "alice#{n}@example.com" }
    password { "alice0123" }
    password_confirmation { "alice0123" }
  end
end
