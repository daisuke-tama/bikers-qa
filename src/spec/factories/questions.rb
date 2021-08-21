FactoryBot.define do
  factory :question do
    title { "bobの物語" }
    content { "この物語のストーリーを教えて下さい" }
    association :user
  end
end
