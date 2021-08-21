require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:article) { create(:article) }

  describe "#index" do
    it "HTTPレスポンスステータステスト200番台を返すこと" do
      get articles_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "HTTPレスポンスステータステスト200番台を返すこと" do
      get article_path(article.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータステスト200番台を返すこと" do
        sign_in article.user
        get new_article_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータステスト302を返すこと" do
        get new_article_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "#edit" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータステスト200番台を返すこと" do
        sign_in article.user
        get edit_article_path(article.id)
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータステスト302を返すこと" do
        get edit_article_path(article.id)
        expect(response).to have_http_status(302)
      end
    end

    context "ログインユーザーが不正に他者の編集画面に転移しようとした場合" do
      let(:unauthorized_user) { create(:user, email: "bob@example.com") }

      it "HTTPレスポンスステータステスト302を返すこと" do
        sign_in unauthorized_user
        get edit_article_path(article.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
