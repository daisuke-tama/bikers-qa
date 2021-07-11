class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :lockable, :trackable, :timeoutable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article

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
end
