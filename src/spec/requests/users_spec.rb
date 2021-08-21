require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "#show" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        sign_in user
        get user_path(user.id)
        expect(response).to have_http_status(:success)
      end

      it "データが取得できていること" do
        sign_in user
        get user_path(user.id)
        expect(response.body).to include user.name
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータス302を返すこと" do
        get user_path(user.id)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "#relationship_index" do
    context "ログインしている場合" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        sign_in user
        get relationship_index_user_path(user.id)
        expect(response).to have_http_status(:success)
      end

      it "データが取得できていること" do
        sign_in user
        get relationship_index_user_path(user.id)
        expect(response.body).to include user.name
      end
    end

    context "未ログインの場合" do
      it "HTTPレスポンスステータス302を返すこと" do
        get relationship_index_user_path(user.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
