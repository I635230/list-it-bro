class PlaylistsController < ApplicationController
  before_action :certificated, only: %i[index create show update destroy add_clip order_clip remove_clip]
  before_action :input_playlist, except: %i[index create]

  # 検索結果を表示
  def index
    playlists = fileter_playlists
    playlists = apply_term(playlists)
    @playlists = apply_order(playlists)
    render status: :ok, json: @playlists
  end

  # 新しいプレイリストを作成
  def create
    @playlist = @current_user.playlists.build(playlist_params)
    @playlist.save
    render status: :created, json: { playlist: "playlist/create" }
  end

  # 特定のプレイリストを表示
  def show
    if @playlist.clips.count == 0
      first_clip_thumbnai_url = "" # TODO: 真っ黒な画像用意しておく。
    else
      first_clip_thumbnai_url = @playlist.clips.first.thumbnail_url # TODO: 実際にはorderの先頭から取り出す必要あり
    end
    render status: :ok, json: @playlist, first_clip_thumbnai_url: first_clip_thumbnai_url
  end

  # 特定のプレイリストを編集
  def update
  end

  # 特定のプレイリストを削除
  def destroy
  end

  # クリップを追加
  def add_clip
    @clip = Clip.friendly.find(params[:clip_id])
    @playlist.add(@clip)
  end

  # クリップを並べ替え
  def order_clip
  end

  # クリップを削除
  def remove_clip
    @clip = Clip.friendly.find(params[:clip_id])
    @playlist.remove(@clip)
  end

  private
    def playlist_params
      params.require(:playlist).permit(:title)
    end

    def input_playlist
      @playlist = Playlist.friendly.find(params[:id])
    end

    def fileter_playlists
      # creatorでソート
      if !params[:creator].nil?

      # titleでソート
      elsif !params[:title].nil?
        # キーワード分割
        keywords = params[:title].split(/[[:blank:]]+/)

        # 初期値
        playlists = []

        # AND検索
        keywords.each_with_index do |keyword, i|
          if i == 0
            playlists = Playlist.where("title LIKE ?", "%#{keyword}%")
          else
            playlists = playlists & Playlist.where("title LIKE ?", "%#{keyword}%")
          end
        end
        playlists

      # 指定なし
      else
        playlists = Playlist.all
      end
    end

    def apply_term(playlists)

      # 1週間
      if params[:term] == "week"
        playlists = playlists.where(created_at: 1.week.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 1カ月
      elsif params[:term] == "month"
        playlists = playlists.where(created_at: 1.month.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 1年
      elsif params[:term] == "year"
        playlists = playlists.where(created_at: 1.year.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 指定なし(全期間)
      else
        # pass
      end
      playlists
    end

    def apply_order(playlists)
      # お気に入り登録が多い順
      if params[:order] == "fav_desc"
        ids = playlists.joins(:favorites).group(:playlist_id).order('count_user_id DESC').count(:user_id).keys
        playlists = Playlist.in_order_of(:id, ids)

      # お気に入り登録が少ない順
      elsif params[:order] == "fav_asc"
        ids = playlists.joins(:favorites).group(:playlist_id).order('count_user_id ASC').count(:user_id).keys
        playlists = Playlist.in_order_of(:id, ids)

      # 日付の新しい順
      elsif params[:order] == "date_desc"
        playlists = playlists.order(created_at: :desc)

      # 日付の古い順
      elsif params[:order] == "date_asc"
        playlists = playlists.order(created_at: :asc)

      # 指定なし(お気に入り登録が多い順)
      else
        ids = playlists.joins(:favorites).group(:playlist_id).order('count_user_id DESC').count(:user_id).keys
        playlists = Playlist.in_order_of(:id, ids)
      end

      playlists = playlists.paginate(page: params[:page], per_page: 20)
    end

end
