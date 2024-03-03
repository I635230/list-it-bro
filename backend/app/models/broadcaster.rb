class Broadcaster < ApplicationRecord
  # 他モデルとの関係
  has_many :clips, dependent: :destroy
end
