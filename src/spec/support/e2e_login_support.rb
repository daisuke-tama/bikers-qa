module E2eLoginSupport
  def login(user)
    visit root_path
    find('#login-btn').click
    sleep 0.5
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログインする'
  end
end
