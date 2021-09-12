class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id)
    @confirmation_notifications = @notifications.where(checked: true).page(params[:page]).per(20)
    @unconfirmed_notifications = @notifications.where(checked: false).page(params[:page]).per(20)
    @unconfirmed_notifications.each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
