class MyBike < ApplicationRecord
  # マイバイクの画像アップロード
  mount_uploader :picture, MyBikePictureUploader
end
