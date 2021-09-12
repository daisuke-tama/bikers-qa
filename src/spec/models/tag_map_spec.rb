require 'rails_helper'

RSpec.describe TagMap, type: :model do
  let(:tag_map) { create(:tag_map) }

  describe '#create' do
    context "全ての値が適正である場合" do
      it "有効であること" do
        expect(tag_map).to be_valid
      end
    end

    context "article_idの値が存在しない場合" do
      it "無効であること" do
        tag_map.article_id = nil
        expect(tag_map).to be_invalid
        expect(tag_map.errors[:article]).to include("を入力してください")
      end
    end

    context "tag_idの値が存在しない場合" do
      it "無効であること" do
        tag_map.tag_id = nil
        expect(tag_map).to be_invalid
        expect(tag_map.errors[:tag]).to include("を入力してください")
      end
    end

    context "tag_idが同じでもarticle_idが違う場合" do
      it "有効であること" do
        other_article = create(:article)
        invalid_tag_map = build(:tag_map, article_id: other_article.id, tag_id: tag_map.tag_id)
        expect(invalid_tag_map).to be_valid
      end
    end

    context "article_idが同じでもtag_idが違う場合" do
      it "有効であること" do
        other_tag = create(:tag)
        invalid_tag_map = build(:tag_map, article_id: tag_map.article_id, tag_id: other_tag.id)
        expect(invalid_tag_map).to be_valid
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "TagMapからみてArticleとの関連付けは" do
      let(:target) { :article }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end

    context "TagMapからみてTagとの関連付けは" do
      let(:target) { :tag }

      it "belongs_toであること" do
        expect(association.macro).to  eq :belongs_to
      end
    end
  end
end
