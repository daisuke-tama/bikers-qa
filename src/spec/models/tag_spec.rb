require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "tag_nameの一意性の検証" do
    let(:first_tag) { create(:tag) } # tag_name { "MyString" }
    let(:after_tag) { build(:tag) } # tag_name { "MyString" }

    context "tag_nameの値がすでに存在していた場合" do
      it "保存されないこと" do
        expect { after_tag.save }.to change(Favorite, :count).by(0)
      end

      it "存在していたtag_nameを参照すること" do
        after_tag.save
        expect(after_tag.tag_name).to eq first_tag.tag_name
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context "TagからみてArticleとの関連付けが" do
      let(:target) { :articles }

      it "has_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end

    context "TagからみてTagMapとの関連付けが" do
      let(:target) { :tag_maps }

      it "has_manyであること" do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
