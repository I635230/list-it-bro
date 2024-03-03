class Clip < ApplicationRecord
  # 代理IDの設定
  include FriendlyId
  friendly_id :slug, use: :finders

  # 他モデルとの関係
  belongs_to :broadcaster
  belongs_to :game
  has_many :playlist_clips, dependent: :destroy
  has_many :playlists, through: :playlist_clips

  # バリデーション
  validates :slug, presence: true, uniqueness: true
end
