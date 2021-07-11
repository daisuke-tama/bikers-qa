class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { in: 100..10000, message: "記事が短すぎるか、長すぎます" }
  # カレントユーザーがこの記事を既にお気に入り登録しているかどうか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
