class User < ApplicationRecord
  # 他モデルとの関係
  has_many :playlists, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_playlists, through: :favorites, source: :playlist

  # バリデーション
  validates :id, uniqueness: true

  # メソッド
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def convert_digest
    User.digest(user_access_token)
  end

  def authenticated?(user_access_digest)
    return false if user_access_token.nil?
    BCrypt::Password.new(user_access_digest).is_password?(user_access_token)
  end

  # favorite関係のメソッド
  def favorite(playlist)
    fav_playlists << playlist
  end

  def unfavorite(playlist)
    fav_playlists.delete(playlist)
  end

  def favorite?(playlist)
    fav_playlists.include?(playlist)
  end
end
