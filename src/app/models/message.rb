class Message < ApplicationRecord
  # ========== アソシエーション関連 ==============
  belongs_to :user
  belongs_to :room
  # 通知機能
  has_many :notifications, dependent: :destroy
  # ===========================================
  # ========== validates ======================
  validates :content, presence: true, length: { maximum: 500 }
  # ===========================================
end
