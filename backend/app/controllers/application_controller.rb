class ApplicationController < ActionController::API
  include HttpDealer

  # 認証：digestが存在するとき、user_idを取得
  def certificated
    if user_id = request.headers["userId"]
      digest = request.headers["userAccessDigest"]
      user = User.find(user_id)

      # digestの情報が正しいかを確認
      if user.authenticated?(digest)
        @current_user = user
      end
    end
  end

  # header変数の定義
  def set_header
    @header = { "Authorization" => ENV["APP_ACCESS_TOKEN"],  "Client-id" => ENV["CLIENT_ID"] }
    @no_client_header = { "Authorization" => ENV["APP_ACCESS_TOKEN"] }
  end

  # Unauthorizedのときに、refresh_tokenを使用して更新する # Unauthorizedのときとかは一旦無視して、普通にrefreshするコード書くか
  def refresh
    header = { 'Content-Type': 'application/x-www-form-urlencoded' }
    uri = "https://id.twitch.tv/oauth2/token"
    body = {
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      grant_type: "refresh_token",
      refresh_token: @current_user.refresh_token,
    }
    res = request_post(header, uri, body)
    user_access_token = "Bearer #{res["access_token"]}"
    refresh_token = res["refresh_token"]

    # トークンの更新
    @curren_user.update(user_access_token: user_access_token, refresh_token: refresh_token)
  end
end
