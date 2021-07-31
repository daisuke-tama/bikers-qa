class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,
  # ======================== devise機能欄 ======================================
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :lockable, :trackable, :timeoutable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)
  # ===========================================================================
  # ======================== アソシエーション関連 ================================
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  has_many :comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :answer_articles, through: :answers, source: :question
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # ===========================================================================
  # プロフィール画像アップロード
  mount_uploader :profile, ProfileUploader

  validates :email, uniqueness: true

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
    find_or_create_by(email: "test@com") do |user|
      user.password = ENV["TEST_LOGIN_PASSWORD"]
    end
  end

  # userが既に相手をフォローしているかどうか
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
