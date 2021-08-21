require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validate" do
    let(:comment) { create(:comment) } # body { "bobはバイク整備が上手だね！" } association :comment user { article.user }

    describe "bodyの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          comment.body = nil
          expect(comment).to be_invalid
          expect(comment.errors[:body]).to include("を入力してください")

          comment.body = ""
          expect(comment).to be_invalid
          expect(comment.errors[:body]).to include("を入力してください")

          comment.body = " "
          expect(comment).to be_invalid
          expect(comment.errors[:body]).to include("を入力してください")
        end
      end

      context "10000字以下の場合" do
        it "有効であること" do
          comment.body = "a" * 10000
          expect(comment).to be_valid
        end
      end

      context "10000以上の場合" do
        it "無効であること" do
          comment.body = "a" * 10001
          expect(comment).to be_invalid
          expect(comment.errors[:body]).to include("は10000文字以内で入力してください")
        end
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "CommentからみてNotificationとの関連付けは" do
      let(:target) { :notifications }

      it "has_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Commentが削除されたらNotificationも削除されること" do
        visitor = create(:user)
        comment = create(:comment)
        create(:notification, comment_id: comment.id, visitor_id: visitor.id, visited_id: comment.user.id)
        expect { comment.destroy }.to change(Comment, :count).by(-1)
      end
    end
  end
end
