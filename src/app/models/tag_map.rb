class TagMap < ApplicationRecord
  belongs_to :article
  belongs_to :tag, dependent: :destroy
end
