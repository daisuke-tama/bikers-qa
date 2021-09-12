require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "validates" do
    context "全ての値が適正である場合" do
      it "有効であること" do
        expect(create(:favorite)).to be_valid
      end
    end

    context "user_idが存在しない場合" do
      it "無効であること" do
        favorite = build(:favorite, user_id: nil)
        favorite.valid?
        expect(favorite.errors[:user_id]).to include("を入力してください")
      end
    end

    context "article_idが存在しない場合" do
      it "無効であること" do
        favorite = build(:favorite, article_id: nil)
        favorite.valid?
        expect(favorite.errors[:article_id]).to include("を入力してください")
      end
    end

    context "article_idとuser_idが一意でない場合" do
      it "無効であること" do
        favorite = create(:favorite)
        favorite2 = build(:favorite, article_id: favorite.article_id, user_id: favorite.user_id)
        favorite2.valid?
        expect(favorite2.errors[:article_id]).to include("はすでに存在します")
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "FavoriteからみてUserとの関連付けは" do
      let(:target) { :user }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "FavoriteからみてArticleとの関連付けは" do
      let(:target) { :article }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
