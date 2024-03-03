def request_get(header, uri)
  res = HTTP[header].get(uri)
  JSON.parse(res.to_s)
end

def request_post(header, uri, body)
  res = HTTP[header].get(uri, json: body)
  JSON.parse(res.to_s)
end

# GameにUndefinedを設定
game = Game.new(id: 0, name: "Undefined")
game.save


# headerの設定
# header = { "Authorization" => ENV["APP_ACCESS_TOKEN"],  "Client-id" => ENV["CLIENT_ID"] }

# 取得するbroadcasters
# broadcaster_ids = [44525650, 49207184]
# broadcaster_ids = [595126758, 807966915]

# 初期Broadcastersの作成
# broadcaster_ids.each do |broadcaster_id|
#   uri = "https://api.twitch.tv/helix/users?id=#{broadcaster_id}"
#   res = request_get(header, uri)
#   data = res["data"][0]
#   Broadcaster.create!(id: data["id"],
#                       login: data["login"],
#                       display_name: data["display_name"],
#                       profile_image_url: data["profile_image_url"])
# end

# BroadcastersのクリップをDBに追加
# broadcaster_ids.each do |broadcaster_id|
#   base_uri = "https://api.twitch.tv/helix/clips?broadcaster_id=#{broadcaster_id}&first=100"
#   @broadcaster = Broadcaster.find(broadcaster_id)
#   after = nil

#   loop do
#     uri = after ? "#{base_uri}&after=#{after}" : "#{base_uri}"
#     res = request_get(header, uri)
#     after = res["pagination"]["cursor"]
#     res["data"].each do |data|

#       # clipの主なデータをテーブルに保存
#       @clip = @broadcaster.clips.build(slug: data["id"],
#                                         creator_id: data["creator_id"],
#                                         game_id: data["game_id"],
#                                         language: data["language"],
#                                         title: data["title"],
#                                         clip_created_at: data["created_at"],
#                                         thumbnail_url: data["thumbnail_url"],
#                                         duration: data["duration"],
#                                         view_count: data["view_count"])
#       if @clip.valid?
#         @clip.save
#       else
#         @clip = Clip.friendly.find(data["id"])
#         @clip.update(view_count: data["view_count"])
#       end
#     end
#     break if after.nil? || after.empty?
#   end
# end
