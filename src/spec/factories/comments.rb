FactoryBot.define do
  factory :comment do
    body { "bobはバイク整備が上手だね！" }
    association :article
    user { article.user }
  end
end
