class Playlist < ApplicationRecord
  before_create -> { self.id = SecureRandom.uuid }
end
