class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # user新規作成の項目追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # user新規作成用
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduce])
  end
end
