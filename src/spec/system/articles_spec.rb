require 'rails_helper'

RSpec.describe 'Articles', type: :system, js: true do
  describe 'CRUD' do
    context '未ログイン' do
      it '新規作成出来ること' do
        user = create(:user)

        login(user)
        find('#new-article-btn').click
        sleep 0.5
        fill_in 'タイトルを入力してください', with: 'aliceの冒険'
        fill_in 'タグ', with: '冒険'
        fill_in_rich_text_area '記事本文', with: 'まず小さくなります'
        expect do
          click_on '確定する'
          sleep 0.5
        end.to change(Article, :count).by(+1)
      end

      it '記事詳細ページに転移できること' do
        article = create(:article)

        visit root_path
        click_on 'aliceの不思議な冒険'
        expect(current_path).to eq article_path(article)
        expect(page).to have_content 'aliceの不思議な冒険'
      end
    end

    context 'ログインしている場合' do
      let(:article) { create(:article) } # title { 'aliceの不思議な冒険' } content { '昔々あるところに・・・' } association :user

      before do
        login(article.user)
      end

      it '記事一覧ページに転移できること' do
        create(:article)

        find('#article-index-btn').click
        sleep 4
        expect(page).to have_content('aliceの不思議な冒険', count: 2)
      end

      it '編集できること' do
        find('.navber-username').click # headerのuser profileアイコン
        sleep 1
        find('.user-show-indextitle').click
        sleep 0.5
        find('.fa-edit').click
        fill_in 'タイトルを入力してください', with: 'bobの物語'
        fill_in 'タグ', with: 'bob'
        fill_in_rich_text_area '記事本文', with: 'まずボブの家に向かいます'
        click_on '上記内容で確定する'
        expect(page).to have_content 'bobの物語'
        expect(page).to have_content 'bob'
        expect(page).to have_content 'まずボブの家に向かいます'
      end

      it 'お気に入り登録ができること' do
        other_article = create(:article)

        visit article_path(other_article)
        expect do
          find('#favorite-btn').click
          sleep 1
        end.to change(Favorite, :count).by(+1)
        sleep 0.5
        expect(page).to have_selector '#unfavorite-btn'
      end
    end
  end
end
