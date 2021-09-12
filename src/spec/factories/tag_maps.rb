FactoryBot.define do
  factory :tag_map do
    association :article
    association :tag
  end
end
