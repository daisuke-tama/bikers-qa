module NotificationsHelper
  # 未確認通知がある場合、ヘッダーの通知ロゴを黄色にするための判別メソッド
  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
