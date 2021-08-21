require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:entry) { create(:entry) }

  describe '#create' do
    context "全ての値が適正である場合" do
      it "有効であること" do
        expect(entry).to be_valid
      end
    end

    context "user_idの値が存在しない場合" do
      it "無効であること" do
        entry.user_id = nil
        expect(entry).to be_invalid
        expect(entry.errors[:user]).to include("を入力してください")
      end
    end

    context "room_idの値が存在しない場合" do
      it "無効であること" do
        entry.room_id = nil
        expect(entry).to be_invalid
        expect(entry.errors[:room]).to include("を入力してください")
      end
    end

    context "user_idとroom_idの組み合わせは一意ではない場合" do
      it "無効であること" do
        invalid_entry = build(:entry, user_id: entry.user_id, room_id: entry.room_id)
        expect(invalid_entry).to be_invalid
        expect(invalid_entry.errors[:room_id]).to include("はすでに存在します")
      end
    end

    context "room_idが同じでもuser_idが違う場合" do
      it "有効であること" do
        other_user = create(:user)
        invalid_entry = build(:entry, user_id: other_user.id, room_id: entry.room_id)
        expect(invalid_entry).to be_valid
      end
    end

    context "user_idが同じでもroom_idが違う場合" do
      it "有効であること" do
        other_room = create(:room)
        invalid_entry = build(:entry, user_id: entry.user_id, room_id: other_room.id)
        expect(invalid_entry).to be_valid
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "EntryからみてUserとの関連付けは" do
      let(:target) { :user }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "EntryからみてRoomとの関連付けは" do
      let(:target) { :room }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
