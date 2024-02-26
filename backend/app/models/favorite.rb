class Favorite < ApplicationRecord
  belongs_to :playlists
  belongs_to :user
  validates :playlist_id, presence: true
  validates :user_id, presence: true
end
