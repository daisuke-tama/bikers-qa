require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validates" do
    let(:user) { create(:user) } # name { "Alice" } introduce { "aliceとbob" } email { "alice@example.com" } password { "alice0123" } password_confirmation { "alice0123" }

    # ============== name validate ==================
    describe "nameの値が" do
      context "無記入や空白の場合" do
        it "無効であること" do
          user.name = nil
          expect(user).to be_invalid
          expect(user.errors[:name]).to include("を入力してください")

          user.name = ""
          expect(user).to be_invalid
          expect(user.errors[:name]).to include("を入力してください")

          user.name = " "
          expect(user).to be_invalid
          expect(user.errors[:name]).to include("を入力してください")
        end
      end

      context "５０文字以下の場合" do
        it "有効であること" do
          user.name = "a" * 50
          expect(user).to be_valid
        end
      end

      context "５０文字を超える場合" do
        it "無効であること" do
          user.name = "a" * 51
          expect(user).to be_invalid
          expect(user.errors[:name]).to include("は50文字以内で入力してください")
        end
      end
    end

    # ============== introduce validate ==================
    describe "introduceの値が" do
      context "500文字を超える場合" do
        it "無効であること" do
          user.introduce = "a" * 501
          expect(user).to be_invalid
          expect(user.errors[:introduce]).to include("は500文字以内で入力してください")
        end
      end
    end

    # ============== email validate ==================
    describe "emailの値が" do # email { "alice@example.com" }
      context "存在しない場合" do
        it "無効であること" do
          user.email = nil
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("を入力してください")
        end
      end

      context "255文字以下の場合" do
        it "有効であること" do
          user.email = "a" * 243 + '@example.com'
          expect(user).to be_valid
        end
      end

      context "255文字以上の場合" do
        it "無効であること" do
          user.email = "a" * 244 + '@example.com'
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("は255文字以内で入力してください")
        end
      end

      context "形式的に適正である場合" do
        it "有効であること" do
          email_address = %w[bob@example.com ALICE@example.COM A_LI-CE@ex.am.ple.com alice+bob@example.jp aaa.bbb@example.ne.jp]
          email_address.each do |valid_address|
            expect(build(:user, email: valid_address)).to be_valid
          end
        end
      end

      context "形式的に不適正である場合" do
        it "無効であること" do
          email_address = %w[alice@example,com alice.in.world @example.com alice@com bob@examplecom bob@example.]
          email_address.each do |invalid_address|
            expect(build(:user, email: invalid_address)).to be_invalid
          end
        end
      end

      context "一意性がない（大文字・小文字の区別なし）場合" do
        it "無効であること" do
          create(:user, email: "bob@example.com")
          user.email = "BOB@ExAmPlE.CoM"
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("はすでに存在します")
        end
      end

      context "データベースに保存される時" do
        it "小文字で登録されること" do
          user.email = "AliCE@EXamPle.cOm"
          user.save!
          expect(user.reload.email).to eq "alice@example.com"
        end
      end
    end
    # ============== password validate ==================
    describe "passwordの値が" do
      context "7文字以上20文字未満の場合" do
        it "有効であること" do
          password = %w[1234567 01234567890123456789]
          password.each do |valid_password|
            expect(build(:user, password: valid_password, password_confirmation: valid_password)).to be_valid
          end
        end
      end

      context "6文字未満場合" do
        it "無効であること" do
          user = build(:user, password: "12345", password_confirmation: "12345")
          expect(user).to be_invalid
          expect(user.errors[:password]).to include("は6文字以上で入力してください")
        end
      end

      context "20文字以上の場合" do
        it "無効であること" do
          user = build(:user, password: "a" * 21, password_confirmation: "a" * 21)
          expect(user).to be_invalid
          expect(user.errors[:password]).to include("は20文字以内で入力してください")
        end
      end

      context "確認用パスワードと一致しない場合" do
        it "無効であること" do
          user = build(:user, password: "alice0123", password_confirmation: "alice01234")
          expect(user).to be_invalid
          expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
        end
      end
    end
  end
end
