FactoryBot.define do
  factory :answer do
    body { "その整備方法は正解です" }
    association :question
    user { question.user }
  end
end
