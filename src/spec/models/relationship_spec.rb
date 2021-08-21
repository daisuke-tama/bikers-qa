require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }

  describe "validates" do
    context "全ての値が揃っている場合" do
      it "有効であること" do
        expect(relationship).to be_valid
      end
    end
    # ============== following_id validate ==================

    describe "following_idが" do
      context "存在しない場合" do
        it "無効であること" do
          relationship.follower_id = nil
          expect(relationship).to be_invalid
        end
      end
    end
    # ============== follower_id validate ==================

    describe "follower_idが" do
      context "存在しない場合" do
        it "無効であること" do
          relationship.following_id = nil
          expect(relationship).to be_invalid
        end
      end
    end

    describe "一意性の検証パターン１" do
      context "follower_idとfollowing_idの組み合わせに一意性がない場合" do
        it "無効であること" do
          invalid_relationship = build(:relationship, follower_id: relationship.follower_id, following_id: relationship.following_id)
          expect(invalid_relationship).to be_invalid
          expect(invalid_relationship.errors[:follower_id]).to include("はすでに存在します")
        end
      end
    end

    describe "一意性の検証パターン２" do
      let(:other_user) { create(:user, email: "bike@example.com") }

      context "follower_idがすでに存在しててもfollowing_idが違う場合" do
        it "有効であること" do
          invalid_relationship = build(:relationship, follower_id: relationship.follower_id, following_id: other_user.id)
          expect(invalid_relationship).to be_valid
        end
      end

      context "following_idがすでに存在しててもfollower_idが違う場合" do
        it "有効であること" do
          invalid_relationship = build(:relationship, follower_id: other_user.id, following_id: relationship.following_id)
          expect(invalid_relationship).to be_valid
        end
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "RelationshipモデルとFollowerとの関連付けは" do
      let(:target) { :follower }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "RelationshipモデルとFollowingとの関連付けは" do
      let(:target) { :following }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
