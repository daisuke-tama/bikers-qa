require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  describe "トップページの機能テスト" do
    context "未ログイン時" do
      it "ホームアイコンが機能していること" do
        visit root_path
        find('#home-btn').click
        expect(current_path).to eq root_path
      end

      it "検索機能が使えること" do
        create(:article)

        visit root_path
        fill_in '記事検索', with: 'alice'
        click_on '検索'
        expect(page).to have_content 'aliceの不思議な冒険'
      end

      it '最新記事から記事詳細ページへ転移できること' do
        article = create(:article)

        visit root_path
        click_on 'aliceの不思議な冒険'
        expect(current_path).to eq article_path(article)
      end

      it "新しい質問から質問詳細ページへ転移できること" do
        question = create(:question) # title { "bobの物語" } content { "この物語のストーリーを教えて下さい" } association :user

        visit root_path
        find('#question-tub').click
        click_on 'bobの物語'
        expect(current_path).to eq question_path(question)
      end

      it "サイト説明ページに転移できること" do
        visit root_path
        find('#about-link-logo').click
        expect(current_path).to eq about_path
      end
    end

    context "ログイン時" do
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it "通知一覧ページへ転移できること" do
        expect(current_path).to eq root_path
        find('.fa-bell').click # headerの通知アイコン
        expect(current_path).to eq notifications_path
      end
    end

    describe "管理者用ページへの転移" do
      let(:user)              { create(:user, admin: true) }
      let(:unauthorized_user) { create(:user, admin: false) }

      context "管理者権限を持つユーザーでログインしている時" do
        it "管理用ページに転移できること" do
          login(user)
          visit rails_admin.dashboard_path
          expect(current_path).to eq rails_admin.dashboard_path
        end
      end

      context "管理者権限がないユーザーでログインしている時" do
        it "管理用ページに転移出来ず、トップページへ転移すること" do
          login(unauthorized_user)
          visit rails_admin.dashboard_path
          expect(current_path).to eq root_path
        end
      end

      context "ログインしていない場合" do
        it "ログイン画面へ転移すること" do
          visit rails_admin.dashboard_path
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end
end
