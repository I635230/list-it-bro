class Playlist < ApplicationRecord
  # 代理IDの設定
  include FriendlyId
  friendly_id :slug, use: :finders

  # 他モデルとの関係
  belongs_to :user
  has_many :playlist_clips, dependent: :destroy
  has_many :clips, through: :playlist_clips
  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  # アクション
  before_create { self.slug = SecureRandom.uuid }

  # バリデーション

  # メソッド
  def add(clip)
    self.clips << clip
  end

  def remove(clip)
    self.clips.destroy(clip.id)
  end

  def favorited?(user)
    fav_users.include?(user)
  end
end
