class AuthenticationsController < ApplicationController

  # ログイン
  def create
    # フロントから認可コードを取得
    code = params[:code]

    # 認可コードを使用して、TwitchAPIからアクセストークンを取得
    header = { 'Content-Type': 'application/x-www-form-urlencoded' }
    uri = "https://id.twitch.tv/oauth2/token"
    body = {
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      code: code,
      grant_type: "authorization_code",
      redirect_uri: "http://localhost:3000"
    }
    res = request_post(header, uri, body)
    user_access_token = "Bearer #{res["access_token"]}"
    refresh_token = res["refresh_token"]

    # アクセストークンを使用して、TwitchAPIからユーザー情報の取得
    header = { "Authorization" => user_access_token, "Client-id" => ENV["CLIENT_ID"] }
    uri = "https://api.twitch.tv/helix/users"
    res = request_get(header, uri)
    data = res["data"][0]

    # ユーザー仮作成
    @user = User.new(id: data["id"],
                     login: data["login"],
                     display_name: data["display_name"],
                     profile_image_url: data["profile_image_url"],
                     user_access_token: user_access_token,
                     refresh_token: refresh_token)

    if @user.valid?
      # ユーザーが存在しなければ作成
      @user.save
    else
      # ユーザーが存在していたらトークンのアップデート
      @user = User.find(data["id"])
      @user.update(user_access_token: user_access_token, refresh_token: refresh_token)
    end

    # render
    user_access_digest = @user.convert_digest
    render status: :created, json: { user_id: @user.id, user_access_digest: user_access_digest }
  end

end
