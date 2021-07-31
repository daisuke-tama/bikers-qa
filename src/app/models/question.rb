class Question < ApplicationRecord
  # ========= アソシエーション関連 ===========
  belongs_to :user
  has_many :answers, dependent: :destroy
  # ActionText(リッチテキスト)機能
  has_rich_text :content
  # ======================================
  # ========= validates ==================
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 20000, message: "が長すぎます" }
  # ======================================
end
