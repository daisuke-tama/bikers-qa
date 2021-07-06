class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { in: 100..10000, message: "記事が短すぎるか、長すぎます" }
end
