FactoryBot.define do
  factory :article do
    title { "aliceの不思議な冒険" }
    content { "昔々あるところに・・・" }
    association :user
  end
end
