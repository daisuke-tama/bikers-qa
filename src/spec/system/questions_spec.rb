require 'rails_helper'

RSpec.describe 'Questions', type: :system, js: true do
  describe 'CRUD' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before do
        login(user)
      end

      it '質問を作成できること' do
        visit root_path

        find('#new-question-btn').click
        fill_in 'タイトル', with: 'aliceの冒険について'
        fill_in_rich_text_area '質問本文', with: 'どうやって小さくなればいいですか？'
        expect do
          click_on '質問をする'
        end.to change(Question, :count).by(+1)
      end
    end
  end
end
