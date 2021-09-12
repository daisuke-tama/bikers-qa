require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "validate" do
    let(:answer) { create(:answer) } # body { "その整備方法は正解です" } association :question user { question.user }

    describe "bodyの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          answer.body = nil
          expect(answer).to be_invalid
          expect(answer.errors[:body]).to include("を入力してください")

          answer.body = ""
          expect(answer).to be_invalid
          expect(answer.errors[:body]).to include("を入力してください")

          answer.body = " "
          expect(answer).to be_invalid
          expect(answer.errors[:body]).to include("を入力してください")
        end
      end

      context "10000字以下の場合" do
        it "有効であること" do
          answer.body = "a" * 10000
          expect(answer).to be_valid
        end
      end

      context "10000以上の場合" do
        it "無効であること" do
          answer.body = "a" * 10001
          expect(answer).to be_invalid
          expect(answer.errors[:body]).to include("は10000文字以内で入力してください")
        end
      end
    end
  end
end
