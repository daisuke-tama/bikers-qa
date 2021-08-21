require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "#create" do
    let(:active_user)  { build(:user) }
    let(:passive_user) { build(:user) }

    describe "userに対し" do
      context "フォローした場合" do
        it "通知が保存できること" do
          notification = build(:notification, visitor_id: active_user.id, visited_id: passive_user.id, action: "follow")
          expect(notification).to be_valid
        end
      end

      context "DMを送った場合" do
        it "通知が保存できること" do
          notification = build(:notification, visitor_id: active_user.id, visited_id: passive_user.id, action: "message")
          expect(notification).to be_valid
        end
      end
    end

    describe "articleに対し" do
      context "コメントした場合" do
        it "通知が保存できること" do
          notification = build(:notification, visitor_id: active_user.id, visited_id: passive_user.id, action: "comment")
          expect(notification).to be_valid
        end
      end

      context "お気に入りした場合" do
        it "通知が保存できること" do
          notification = build(:notification, visitor_id: active_user.id, visited_id: passive_user.id, action: "favorite")
          expect(notification).to be_valid
        end
      end
    end

    describe "questionに対し" do
      context "回答した場合" do
        it "通知が保存できること" do
          notification = build(:notification, visitor_id: active_user.id, visited_id: passive_user.id, action: "answer")
          expect(notification).to be_valid
        end
      end
    end
  end

  describe "アソシエーションのテスト" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "NotificationとMessageとの関連付けは" do
      let(:target) { :message }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "NotificationとArticleとの関連付けは" do
      let(:target) { :article }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "NotificationとRoomとの関連付けは" do
      let(:target) { :room }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "NotificationとCommentとの関連付けは" do
      let(:target) { :comment }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "NotificationとVisitorとの関連付けは" do
      let(:target) { :visitor }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end

    context "NotificationとVisitedとの関連付けは" do
      let(:target) { :visited }

      it "belongs_toであること" do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
