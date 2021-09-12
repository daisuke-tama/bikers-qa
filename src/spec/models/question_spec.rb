require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "validates" do
    let(:question) { create(:question) } # title { "bobの物語" } content { "この物語のストーリーを教えて下さい" } association :user

    describe "全ての値が" do
      context "適正の場合" do
        it "有効であること" do
          expect(question).to be_valid
        end
      end
    end
    # ============== title validate ==================

    describe "titleの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          question.title = nil
          expect(question).to be_invalid
          expect(question.errors[:title]).to include("を入力してください")

          question.title = ""
          expect(question).to be_invalid
          expect(question.errors[:title]).to include("を入力してください")

          question.title = " "
          expect(question).to be_invalid
          expect(question.errors[:title]).to include("を入力してください")
        end
      end

      context "100文字以下の場合" do
        it "有効であること" do
          question.title = "a" * 100
          expect(question).to be_valid
        end
      end

      context "100文字以上の場合" do
        it "無効であること" do
          question.title = "a" * 101
          expect(question).to be_invalid
        end
      end
    end
    # ============== question_body validate ==================

    describe "contentの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          question.content = nil
          expect(question).to be_invalid
          expect(question.errors[:content]).to include("を入力してください")

          question.content = ""
          expect(question).to be_invalid
          expect(question.errors[:content]).to include("を入力してください")

          question.content = " "
          expect(question).to be_invalid
          expect(question.errors[:content]).to include("を入力してください")
        end
      end

      context "20000字以下の場合" do
        it "有効であること" do
          question.content = "a" * 19963 # ActionText使用のためHTMLタグなどが数に含まれます
          expect(question).to be_valid
        end
      end

      context "20000字以上の場合" do
        it "無効であること" do
          question.content = "a" * 19964 # ActionText使用のためHTMLタグなどが数に含まれます
          expect(question).to be_invalid
          expect(question.errors[:content]).to include("は20000文字以内で入力してください")
        end
      end
    end
  end
end
