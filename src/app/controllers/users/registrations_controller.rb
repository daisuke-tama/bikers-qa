class Users::RegistrationsController < Devise::RegistrationsController 
  before_action :configure_account_update_params, only: [:update]

  protected

  # ひとまずユーザー編集時、パスワード入力無しで行えるようにする。
  # 将来的に削除予定
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
  # ユーザ編集時、nameカラムの変更許可
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
