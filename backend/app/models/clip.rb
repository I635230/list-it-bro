class Clip < ApplicationRecord
  has_one :clip_view_count, dependent: :destroy
  validates :id, uniqueness: true
end
