FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@example.com" }
    password { "testtesttest" }
    password_confirmation { "testtesttest" }
  end
end
