class ClipSerializer < ActiveModel::Serializer
  attributes %i[clip_id]
  # attributes %i[clip_id broadcaster_id creator_id game_id language title view_count created_at thumbnail_url duration]
  
  def clip_id
    "clip_id_desuyo"
  end
end
