class Room < ApplicationRecord
  # =============== アソシエーション関連 ==================
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # ===================================================
  # ============== validates ==========================
  validates :name, presence: true, length: { maximum: 100 }
  # ===================================================
end
