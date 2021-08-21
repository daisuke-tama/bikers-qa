require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  it '新規登録できること' do
    visit root_path
    find('#new-user-btn').click
    sleep 0.5
    fill_in '名前を入力してください', with: 'alice'
    fill_in '自己紹介内容を入力してください', with: 'はじめまして'
    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワードを入力してください', with: 'asdfgh'
    fill_in '確認のためもう一度入力してください', with: 'asdfgh'
    click_on '新規会員登録する'

    expect(page).to have_content 'アカウント登録が完了しました'
  end

  it '編集ができること' do
    user = create(:user)

    login(user)
    find('.navber-username').click # headerのuser prfileアイコン
    click_on 'プロフィールを編集する'
    fill_in '名前を入力してください', with: 'bob'
    fill_in '自己紹介内容を入力してください', with: 'はじめまして'
    fill_in 'メールアドレス', with: 'bob@example.com'
    click_on '編集を完了する'

    expect(page).to have_content 'アカウント情報を変更しました'
    expect(page).to have_content 'bob'
    expect(page).to have_content 'はじめまして'
  end

  it '削除できること' do
    user = create(:user)

    login(user)
    find('.navber-username').click # headerのuser prfileアイコン
    click_on 'プロフィールを編集する'
    click_on 'アカウント削除'

    expect do
      expect(page.accept_confirm).to eq 'アカウントを削除すると戻すことは出来ません。本当によろしいですか？'
      expect(page).to have_content 'アカウントを削除しました'
    end.to change(User, :count).by(-1)
  end

  it "フォロー機能が使えること" do
    user = create(:user)
    other_user = create(:user)

    login(user)
    visit user_path(other_user)
    expect do
      find('#follow-btn').click
      sleep 0.5
      expect(page).to have_content 'フォロー解除'
    end.to change(Relationship, :count).by(+1)
  end
end
