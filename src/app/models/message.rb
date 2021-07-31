class Message < ApplicationRecord
  # ========== アソシエーション関連 ==============
  belongs_to :user
  belongs_to :room
  # ===========================================
  # ========== validates ======================
  validates :content, presence: true, length: { maximum: 500 }
  # ===========================================
end
