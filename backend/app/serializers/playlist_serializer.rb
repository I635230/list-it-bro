class PlaylistSerializer < ActiveModel::Serializer
  attributes %i[slug title user_id first_clip_thumbnai_url favorites_count]

  def initialize(object, options = {})
    super(object, options)
    @first_clip_thumbnail_url = options[:first_clip_thumbnai_url]
  end

  def first_clip_thumbnai_url
    @first_clip_thumbnail_url
  end

  def favorites_count
    object.fav_users.count
  end
end
