class Comment < ApplicationRecord
  # =========== アソシエーション関連 =================
  belongs_to :user
  belongs_to :article
  # ==============================================
  # =========== validates ========================
  validates :body, presence: true, length: { maximum: 10000 }
  # ==============================================
end
