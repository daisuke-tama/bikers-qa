require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "#index" do
    it "HTTPレスポンスステータス200番台を返すこと" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
