require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "validates" do
    let(:room) { create(:room) } # name { "整備について話す部屋" }
    # ============== name validate ==================

    describe "nameの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          room.name = nil
          expect(room).to be_invalid
          expect(room.errors[:name]).to include("を入力してください")

          room.name = ""
          expect(room).to be_invalid
          expect(room.errors[:name]).to include("を入力してください")

          room.name = " "
          expect(room).to be_invalid
          expect(room.errors[:name]).to include("を入力してください")
        end
      end
    end

    context "100文字以下の場合" do
      it "有効であること" do
        room.name = "a" * 100
        expect(room).to be_valid
      end
    end

    context "100文字以上の場合" do
      it "無効であること" do
        room.name = "a" * 101
        expect(room).to be_invalid
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "Roomモデルと" do
      let(:target) { :entries }
      let(:target) { :messages }
      let(:target) { :notifications }

      it "Entrieとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Messageとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Notificationとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
