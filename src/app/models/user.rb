class User < ApplicationRecord
  before_save :email_downcase
  # Include default devise modules. Others available are:
  # :confirmable,
  # ======================== devise機能欄 ======================================
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :lockable, :trackable, :timeoutable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)
  # ===========================================================================
  # ====================== アソシエーション関連 ================================
  has_many :articles, dependent: :destroy
  # 記事に対するお気に入り機能
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  # フォロー フォロワー機能
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # 記事に対するコメント機能
  has_many :comments, dependent: :destroy
  # 質問機能
  has_many :questions, dependent: :destroy
  # 質問に対する回答機能
  has_many :answers, dependent: :destroy
  has_many :answer_articles, through: :answers, source: :question
  # user間のダイレクトメッセージ機能
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # ===========================================================================
  # プロフィール画像アップロード
  mount_uploader :profile, ProfileUploader
  # =========== validates ===============
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduce, length: { maximum: 500 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, message: "が有効ではありません" },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { in: 6..20 }, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  # ========================================

  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # テストログイン用
  def self.guest
    find_or_create_by(email: "test@gmail.com") do |user|
      user.password = ENV["TEST_LOGIN_PASSWORD"]
    end
  end

  # userが既に相手をフォローしているかどうか
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # 通知機能
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  private

  def email_downcase
    self.email = email.downcase
  end
end
