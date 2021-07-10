require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe "#show" do
    it "HTTPレスポンスステータス200番台を返すこと" do
      sign_in @user
      get user_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
