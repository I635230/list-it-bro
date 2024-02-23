class TwitchesController < ApplicationController
  def get_clips
    # 初期設定
    header = { "Authorization" => ENV["APP_ACCESS_TOKEN"],  "Client-id" => ENV["CLIENT_ID"] }
    base_uri = "https://api.twitch.tv/helix/clips?broadcaster_id=44525650&first=100"
    all = params[:all] || "false"
    n = 10 # 何時間前からの情報を取得するか
    current_datetime = DateTime.now
    current_rfc3339 = current_datetime.strftime("%Y-%m-%dT%H:%M:%SZ")
    n_hour_ago_datetime = current_datetime - Rational(n, 24)
    n_hour_ago_rfc3339 = n_hour_ago_datetime.strftime("%Y-%m-%dT%H:%M:%SZ")

    after = nil
    loop do
      # allの場合は全期間、そうでないときは4時間前までのクリップを取得
      if all == "true"
        uri = after ? "#{base_uri}&after=#{after}" : "#{base_uri}"
      else
        uri = after ? "#{base_uri}&after=#{after}&started_at=#{n_hour_ago_rfc3339}&ended_at=#{current_rfc3339}" : "#{base_uri}&started_at=#{n_hour_ago_rfc3339}&ended_at=#{current_rfc3339}"
      end

      res = request_get(header, uri)
      after = res["pagination"]["cursor"]
      res["data"].each do |data|
        @clip = Clip.new(id:data["id"], broadcaster_id:data["broadcaster_id"], creator_id:data["creator_id"], game_id:data["game_id"], language:data["language"], title:data["title"], clip_created_at:data["created_at"], thumbnail_url:data["thumbnail_url"], duration:data["duration"])
        @clip.save
        @clip_view_count = @clip.build_clip_view_count(view_count: data["view_count"])
        if @clip_view_count.save
          # pass
        else
          @clip_view_count = ClipViewCount.find_by(clip_id: data["id"])
          @clip_view_count.update(view_count: data["view_count"])
        end
      end
      break
      # break if after.nil? || after.empty?
    end
    render status: :ok # 仮置きのok
  end
  
  private
    def request_get(header, uri)
      res = HTTP[header].get(uri)
      JSON.parse(res.to_s)
    end

    def request_post(header, uri, body)
      res = HTTP[header].get(uri, json: body)
      JSON.parse(res.to_s)
    end
end
