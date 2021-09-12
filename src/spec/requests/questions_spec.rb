require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:question) { create(:question) }

  describe "#index" do
    it "HTTPレスポンスステータス200番台を返すこと" do
      get questions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "HTTPレスポンスステータス200番台を返すこと" do
      get question_path(question.id)
      expect(response).to have_http_status(:success)
    end

    it "データが取得できていること" do
      get question_path(question.id)
      expect(response.body).to include question.title
    end
  end

  describe "#new" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        sign_in question.user
        get new_question_path
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータス302を返すこと" do
        get new_question_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "#edit" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        sign_in question.user
        get edit_question_path(question.id)
        expect(response).to have_http_status(:success)
      end

      it "データが取得できていること" do
        sign_in question.user
        get edit_question_path(question.id)
        expect(response.body).to include question.title
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータス302を返すこと" do
        get edit_question_path(question.id)
        expect(response).to have_http_status(302)
      end
    end

    context "ログインユーザーが不正に他者の編集画面に転移しようとした場合" do
      let(:unauthorized_user) { create(:user, email: "bob@example.com") }

      it "HTTPレスポンスステータス302を返すこと" do
        sign_in unauthorized_user
        get edit_question_path(question.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
