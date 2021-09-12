class Room < ApplicationRecord
  # =============== アソシエーション関連 ==================
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # 通知機能
  has_many :notifications, dependent: :destroy
  # ===================================================
  # ============== validates ==========================
  validates :name, presence: true, length: { maximum: 100 }
  # ===================================================

  def create_notification_message!(current_user, room_id)
    temp_ids = Entry.where(room_id: room_id).where.not(user_id: current_user.id)
    notification = current_user.active_notifications.new(
      message_id: id,
      room_id: room_id,
      visitor_id: temp_ids.user_id,
      visited_id: visited_id,
      action: 'message'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
