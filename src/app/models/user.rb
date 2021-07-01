class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable :confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :lockable, :trackable, :timeoutable
  # 無記入防止
  validates_presence_of :name
  # emailに@がなくてはならない+エラーメッセージの変更。一意性の検証
  validates :email, { format: { with: VALID_EMAIL_ERGEX, message: "には@を含めた有効なアドレスを入力してください" }, uniqueness: { case_sensitive: false } }
  # createアクション時のみpasswordの長さを6文字から20文字以内に指定
  validates :password, length: { in: 6..20 }, on: :create
  # パスワード入力が2回とも同じ内容かを判別
  validates_confirmation_of :password
end
