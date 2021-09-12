class Article < ApplicationRecord
  # ========== アソシエーション関連 =================
  belongs_to :user
  # お気に入り機能
  has_many :favorites, dependent: :destroy
  # タグ機能
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  # コメント機能
  has_many :comments, dependent: :destroy
  # Action Text(リッチテキスト)機能
  has_rich_text :content
  # 通知機能
  has_many :notifications, dependent: :destroy
  # ================================================
  # ========= validates ============================
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 20000 }
  # ================================================
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

  # 通知機能
  def create_notification_favorite!(current_user)
    # すでに「お気に入り」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # お気に入りされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するお気に入りの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 過去にコメント（回答）したuserの選出
    # commentモデルのuser_id(article_idがコメント（回答）した記事（質問）のid)を取得。ただし、自身の記事（質問）にコメント(回答)したデータは取得しない+重複禁止
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      # 取得したuser全員に通知を送る
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
