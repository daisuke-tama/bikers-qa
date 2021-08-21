require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validate" do
    describe "messageの値が" do
      let(:message) { build(:message) } # content { "初めましてこんにちは" } association :user association :room

      context "contentが無記入や空白の場合" do
        it "無効であること" do
          message.content = nil
          expect(message).to be_invalid
          expect(message.errors[:content]).to include("を入力してください")

          message.content = ""
          expect(message).to be_invalid
          expect(message.errors[:content]).to include("を入力してください")

          message.content = " "
          expect(message).to be_invalid
          expect(message.errors[:content]).to include("を入力してください")
        end
      end

      context "500字以上の場合" do
        it "無効であること" do
          message.content = "a" * 501
          expect(message).to be_invalid
        end
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "MessageからみてUserとの関連付けは" do
      let(:target) { :user }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "MessageからみてRoomとの関連付けは" do
      let(:target) { :room }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "MessageからみてNotificationとの関連付けは" do
      let(:target) { :notifications }

      it "has_manyであること" do
        expect(association.macro).to  eq :has_many
      end

      it "Messageが削除されたらNotificationも削除されること" do
        visitor = create(:user)
        message = create(:message)
        create(:notification, message_id: message.id, visitor_id: visitor.id, visited_id: message.user.id)
        expect { message.destroy }.to change(Notification, :count).by(-1)
      end
    end
  end
end
