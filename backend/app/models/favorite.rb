class Favorite < ApplicationRecord
  # 他モデルとの関係
  belongs_to :playlist
  belongs_to :user
  validates :playlist_id, presence: true
  validates :user_id, presence: true
end
