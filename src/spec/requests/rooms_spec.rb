require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "#show" do
    let(:entry) { create(:entry) } # association :user association :room

    context "転移先のダイレクトメッセージルームに登録されているユーザーの場合" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        sign_in entry.user
        get room_path(entry.room_id)
        expect(response).to have_http_status(:success)
      end

      it "データが取得できていること" do
        sign_in entry.user
        get room_path(entry.room_id)
        expect(response.body).to include entry.room.name
      end
    end

    context "登録されていないユーザーが不正に侵入した場合" do
      let(:unauthorized_user) { create(:user) }

      it "HTTPレスポンスステータス302を返すこと" do
        sign_in unauthorized_user
        get room_path(entry.room_id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
