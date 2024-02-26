class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_clips, dependent: :destroy
  has_many :clips, through: :playlist_clips
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  before_create -> { self.id = SecureRandom.uuid }
end
