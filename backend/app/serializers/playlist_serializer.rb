class PlaylistSerializer < ActiveModel::Serializer
  attributes %i[slug title creator_name first_clip_thumbnail_url clips_count favorites_count created_at]

  def creator_name
    object.user.display_name
  end

  def first_clip_thumbnail_url
    if object.clips.count == 0
      first_clip_thumbnail_url = "" # TODO: 真っ黒な画像用意しておく。
    else
      object.clips.first.thumbnail_url
    end
  end

  def clips_count
    object.clips.count
  end

  def favorites_count
    object.fav_users.count
  end
end
