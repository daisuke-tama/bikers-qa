module NotificationsHelper
  # ヘッダーの通知ロゴ上に未確認マークを付けるため
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
