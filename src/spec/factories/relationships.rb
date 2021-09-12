FactoryBot.define do
  factory :relationship do
    follower_id  { create(:user, email: "alice@example.com").id }
    following_id { create(:user, email: "bob@example.com").id }
  end
end
