class ClipTwitchId < ApplicationRecord
  belongs_to :clip
  validates :clip_twitch_id, uniqueness: true
end
