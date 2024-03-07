class ClipSerializer < ActiveModel::Serializer
  attributes %i[slug broadcaster_name creator_name game_name game_image language title view_count clip_created_at thumbnail_url duration]
end

def game_name
  self.game.name
end

def game_image
  self.game.box_art_url
end

def broadcaster_name
  self.broadcaster.name
end
