class Users::SessionsController < Devise::SessionsController
  # テストログイン用
  def guest_login
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "Thank you for your testing!"
  end
end
