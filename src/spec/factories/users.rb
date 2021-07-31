FactoryBot.define do
  factory :user do
    name { "test" }
    email { "test@gmail.com" }
    password { "testtesttest" }
    password_confirmation { "testtesttest" }
  end
end
