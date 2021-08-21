require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  describe 'CRUD' do
    context '記事が存在、かつログインしている場合' do
      it 'コメントできること' do
        article = create(:article)

        login(article.user)
        visit article_path(article)

        fill_in 'create-comment-form', with: 'いい記事ですね'
        expect  do
          click_on 'コメントする'
        end.to change(Comment, :count).by(+1)
      end
    end
  end
end
