require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "ArticlesTest" do
    let(:article) { create(:article, :skip_validate) }

    describe "#index" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        get articles_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "#show" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        get article_path(article.id)
        expect(response).to have_http_status(:success)
      end
    end

    describe "#new" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        get new_article_path
        expect(response).to have_http_status(:success)
      end
    end

    describe "#edit" do
      it "HTTPレスポンスステータス200番台を返すこと" do
        get edit_article_path(article.id)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
