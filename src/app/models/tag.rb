class Tag < ApplicationRecord
  has_many :tag_maps
  has_many :articles, through: :tag_maps
end
