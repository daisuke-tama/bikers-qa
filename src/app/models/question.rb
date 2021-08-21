class Question < ApplicationRecord
  # ========= アソシエーション関連 ===========
  belongs_to :user
  has_many :answers, dependent: :destroy
  # 通知機能
  has_many :notifications, dependent: :destroy
  # ActionText(リッチテキスト)機能
  has_rich_text :content
  # ======================================
  # ========= validates ==================
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 20000 }
  # ======================================

  def create_notification_answer!(current_user, answer_id)
    temp_ids = Answer.select(:user_id).where(question_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_answer!(current_user, answer_id, temp_id['user_id'])
    end
    save_notification_answer!(current_user, answer_id, user_id) if temp_ids.blank?
  end

  def save_notification_answer!(current_user, answer_id, visited_id)
    notification = current_user.active_notifications.new(
      question_id: id,
      answer_id: answer_id,
      visited_id: visited_id,
      action: 'answer'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
