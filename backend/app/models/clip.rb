class Clip < ApplicationRecord
  has_one :clip_view_count, dependent: :destroy
  has_one :clip_twitch_id, dependent: :destroy
  has_many :playlist_clips, dependent: :destroy
  has_many :playlists, through: :playlist_clips
end
