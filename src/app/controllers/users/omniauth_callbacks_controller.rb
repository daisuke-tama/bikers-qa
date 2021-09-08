class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # callback for twitter
  def twitter
    callback_for(:twitter)
  end

  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # common callback method
  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"]) # sns認証先のユーザー情報を@userに代入
    duplicate_confirmation_token = User.find_by(email: "#{@user.email}") # @userが既に保存されているかの確認に使用（emailで判断する)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    elsif duplicate_confirmation_token.present? # @userが既存のユーザーとemailが重複する場合トップページへ転移
      redirect_to root_path
      flash[:alert] = "既に登録されているメールアドレスを使用しているので登録出来ませんでした"
    else # 何らかの原因で@userが保存されなかった場合、session情報を持たせて新規登録画面へ転移させる
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
