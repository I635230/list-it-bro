class ClipSerializer < ActiveModel::Serializer
  attributes %i[slug broadcaster_id creator_name game_id language title view_count clip_created_at thumbnail_url duration]
end
