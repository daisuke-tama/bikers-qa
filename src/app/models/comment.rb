class Comment < ApplicationRecord
  # =========== アソシエーション関連 =================
  belongs_to :user
  belongs_to :article
  # 通知機能
  has_many :notifications, dependent: :destroy
  # ==============================================
  # =========== validates ========================
  validates :body, presence: true, length: { maximum: 10000 }
  # ==============================================
end
