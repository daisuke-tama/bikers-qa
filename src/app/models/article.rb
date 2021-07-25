class Article < ApplicationRecord
  belongs_to :user
  # お気に入り機能
  has_many :favorites, dependent: :destroy
  # タグ機能
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  # コメント機能
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { in: 1..10000, message: "記事が短すぎるか、長すぎます" }
  # userがこの記事を既にお気に入り登録しているかどうか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # タグ付け機能
  def tags_save(tag_list)
    # 既にタグ付けをしていた場合、全て削除し紐付けを解除
    if self.tags != nil
      article_tags_records = TagMap.where(article_id: self.id)
      article_tags_records.destroy_all
    end
    # tagsテーブルからtag_listの値が保存されていればレコードを取得。未保存なら保存する
    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
    end
  end
end
