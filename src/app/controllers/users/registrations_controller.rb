class Users::RegistrationsController < Devise::RegistrationsController
  # user新規作成・編集の許可項目追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  # プロフィール編集後のリダイレクト先
  def after_update_path_for(resource)
    user_path(resource)
  end

  protected

  # ユーザー編集時、パスワード入力無しで行えるようにする。
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # user新規作成・編集用
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduce, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduce, :profile, :remove_profile])
  end
end
