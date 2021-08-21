require 'rails_helper'

RSpec.describe 'Answers', type: :system, js: true do
  describe 'CRUD' do
    context '記事が存在、かつログインしている場合' do
      let(:question) { create(:question) } # title { "bobの物語" } content { "この物語のストーリーを教えて下さい" } association :user

      before do
        login(question.user)
      end

      it '回答できること' do
        visit root_path

        find('#question-index-btn').click
        click_on 'bobの物語'
        fill_in 'create-answer-form', with: '魔法を使いましょう'
        expect  do
          click_on '回答する'
        end.to change(Answer, :count).by(+1)
      end
    end
  end
end
