require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validates" do
    let(:article) { create(:article) } # title { "aliceの不思議な冒険" } content { "昔々あるところに・・・" } association :user

    describe "全ての値が" do
      context "適正の場合" do
        it "有効であること" do
          expect(article).to be_valid
        end
      end
    end
    # ============== title validate ==================

    describe "titleの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          article.title = nil
          expect(article).to be_invalid
          expect(article.errors[:title]).to include("を入力してください")

          article.title = ""
          expect(article).to be_invalid
          expect(article.errors[:title]).to include("を入力してください")

          article.title = " "
          expect(article).to be_invalid
          expect(article.errors[:title]).to include("を入力してください")
        end
      end

      context "100文字以下の場合" do
        it "有効であること" do
          article.title = "a" * 100
          expect(article).to be_valid
        end
      end

      context "100文字以上の場合" do
        it "無効であること" do
          article.title = "a" * 101
          expect(article).to be_invalid
        end
      end
    end
    # ============== content validate ==================

    describe "contentの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          article.content = nil
          expect(article).to be_invalid
          expect(article.errors[:content]).to include("を入力してください")

          article.content = ""
          expect(article).to be_invalid
          expect(article.errors[:content]).to include("を入力してください")

          article.content = " "
          expect(article).to be_invalid
          expect(article.errors[:content]).to include("を入力してください")
        end
      end

      context "20000字以下の場合" do
        it "有効であること" do
          article.content = "a" * 19963 # ActionText使用のためHTMLタグなどが数に含まれます
          expect(article).to be_valid
        end
      end

      context "20000字以上の場合" do
        it "無効であること" do
          article.content = "a" * 19964 # ActionText使用のためHTMLタグなどが数に含まれます
          expect(article).to be_invalid
          expect(article.errors[:content]).to include("は20000文字以内で入力してください")
        end
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:article)    { create(:article) }
    let(:other_user) { create(:user, name: "bob", email: "bob@example.com") }

    context "favoriteモデルとのアソシエーション" do
      let(:target) { :favorites }

      it "favoriteとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "articleが削除されたらfavoriteも削除されること" do
        create(:favorite, article_id: article.id, user_id: other_user.id)
        expect { article.destroy }.to change(Favorite, :count).by(-1)
      end
    end

    context "Commentモデルとのアソシエーション" do
      let(:target) { :comments }

      it "Commentとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "articleが削除されたらCommentも削除されること" do
        create(:comment, article_id: article.id)
        expect { article.destroy }.to change(Comment, :count).by(-1)
      end
    end

    context "Notificationsモデルとのアソシエーション" do
      let(:target) { :notifications }

      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "articleが削除されたらNotificationも削除されること" do
        create(:notification, article_id: article.id, visitor_id: 1, visited_id: 1)
        expect { article.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end
end
