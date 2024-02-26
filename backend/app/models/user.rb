class User < ApplicationRecord
  has_many :playlists, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_playlists, through: :favorites, source: :playlist
end
