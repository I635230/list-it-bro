class PlaylistClip < ApplicationRecord
  belongs_to :playlist
  belongs_to :clip

  validates :playlist_id, uniqueness: { scope: :clip_id } # プレイリストに同じクリップは入れられない
end
