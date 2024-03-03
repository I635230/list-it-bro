class TwitchesController < ApplicationController
  before_action :certificated, only: %i[get_follow_broadcasters]
  before_action :set_header, only: %i[get_clip_broadcaster get_games get_clips]

  # clipIdからbroadcasterIdを取得する
  def get_clip_broadcaster
    clip_id = params[:clip_id]

    uri = "https://api.twitch.tv/helix/clips?id=#{clip_id}"
    res = request_get(@header, uri)

    data = res["data"][0]

    # jaチェック
    return if data["language"] != "ja"

    broadcaster_id = data["broadcaster_id"]
    render status: :ok, json: broadcaster_id
  end

  # userがfollow中のbroadcastersのデータを取得する
  def get_follow_broadcasters
    header = { "Authorization" => @current_user.user_access_token, "Client-id" => ENV["CLIENT_ID"] }
    user_id = @current_uuser.id
    uri = "https://api.twitch.tv/helix/channels/followed?user_id=#{user_id}&first=100"
    res = request_get(header, uri)
    render status: :ok, json: res["data"]
  end

  # あるbroadcasterのクリップを取得する
  def get_clips
    # 基本設定
    broadcaster_id = params[:broadcaster_id]
    @broadcaster = Broadcaster.find(broadcaster_id)

    base_uri = "https://api.twitch.tv/helix/clips?broadcaster_id=#{broadcaster_id}&first=100"
    all = params[:all]

    # 時間設定
    n = 10 # 何時間前からの情報を取得するか
    current_datetime = DateTime.now
    current_rfc3339 = current_datetime.strftime("%Y-%m-%dT%H:%M:%SZ")
    n_hour_ago_datetime = current_datetime - Rational(n, 24)
    n_hour_ago_rfc3339 = n_hour_ago_datetime.strftime("%Y-%m-%dT%H:%M:%SZ")

    after = nil
    loop do
      # allの場合は全期間、そうでないときはn時間前までのクリップを取得
      if all == true
        uri = after ? "#{base_uri}&after=#{after}" : "#{base_uri}"
      else
        uri = after ? "#{base_uri}&after=#{after}&started_at=#{n_hour_ago_rfc3339}&ended_at=#{current_rfc3339}" : "#{base_uri}&started_at=#{n_hour_ago_rfc3339}&ended_at=#{current_rfc3339}"
      end

      res = request_get(@header, uri)
      after = res["pagination"]["cursor"]
      view_count = 2000
      res["data"].each do |data|

        # game_idが空のときは、Undefinedに設定
        data["game_id"] = 0 if data["game_id"] == ""

        # gameの存在確認
        create_game(data["game_id"]) if !Game.find_by(id: data["game_id"])

        # clipの主なデータをテーブルに保存
        @clip = @broadcaster.clips.build(slug: data["id"],
                                         broadcaster_name: data["broadcaster_name"],
                                         creator_id: data["creator_id"],
                                         creator_name: data["creator_name"],
                                         game_id: data["game_id"],
                                         language: data["language"],
                                         title: data["title"],
                                         clip_created_at: data["created_at"],
                                         thumbnail_url: data["thumbnail_url"],
                                         duration: data["duration"],
                                         view_count: data["view_count"])
        if @clip.valid?
          @clip.save
        else
          @clip = Clip.friendly.find(data["id"])
          @clip.update(view_count: data["view_count"])
        end
        view_count = data["view_count"]
      end
      # break if after.nil? || after.empty? || view_count < 5000
      break if after.nil? || after.empty?
    end
    render status: :created # 仮置きのcreated
  end

  private

    # 特定のgameデータを取得
    def create_game(id)
      uri = "https://api.twitch.tv/helix/games?id=#{id}"

      # メイン処理
      res = request_get(@header, uri)
      data = res["data"][0]

      # 重複チェック
      return if Game.find_by(id: data["id"])

      # gameデータをテーブルに保存
      @game = Game.new(id: data["id"],
                      name: data["name"],
                      box_art_url: data["box_art_url"])
      @game.save
    end
end
