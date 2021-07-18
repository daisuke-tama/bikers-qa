class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # user新規作成・編集の項目追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # user新規作成・編集用
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduce])
    devise_parameter_sanitizer.permit(:account_update, keys: [:introduce])
  end
end
