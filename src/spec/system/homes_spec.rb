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
  end
end
