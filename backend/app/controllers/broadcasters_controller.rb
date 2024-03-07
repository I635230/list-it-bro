class BroadcastersController < ApplicationController
  before_action :set_header, only: %i[create]

  def index
    render status: :ok, json: Broadcaster.all.map(&:display_name)
  end

  def create
    # 準備
    broadcaster_id = params[:broadcaster_id]
    uri = "https://api.twitch.tv/helix/users?id=#{broadcaster_id}"

    # 存在チェック
    return if Broadcaster.find_by(id: broadcaster_id)

    # データ取得
    res = request_get(@header, uri)
    data = res["data"][0]

    # Broadcaster作成
    Broadcaster.create!(id: data["id"],
                        login: data["login"],
                        display_name: data["display_name"],
                        profile_image_url: data["profile_image_url"])

    render status: :created
  end
end
