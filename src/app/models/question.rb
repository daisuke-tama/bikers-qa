class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy

  has_rich_text :content

  validates :title, presence: true
end
