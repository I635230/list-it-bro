class PlaylistsController < ApplicationController
  before_action :certificated, only: %i[index create show update destroy add_clip order_clip remove_clip]
  before_action :input_playlist, except: %i[index create]

  # 検索結果を表示
  def index
    playlists = fileter_playlists
    playlists = apply_term(playlists)
    apply_order(playlists)
    render status: :ok, json: @playlists, each_serializer: PlaylistSerializer, meta: {elementsCount: @playlists_all_page.size, limit: 20}, adapter: :json
  end

  # 新しいプレイリストを作成
  def create
    @playlist = @current_user.playlists.build(playlist_params)
    @playlist.save
    render status: :created
  end

  # 特定のプレイリストを表示
  def show
    render status: :ok, json: @playlist
  end

  # 特定のプレイリストを編集
  def update
    if @playlist.update(playlist_params)
      render status: :created, json: @playlist
    else
      render status: :unprocessable_entity, json: @playlist.errors
    end
  end

  # 特定のプレイリストを削除
  def destroy
    # TODO: 正しいユーザーかを確認する処理
    @playlist.destroy
    render status: :no_content
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
        playlists = Playlist.joins(:user).where(users: { display_name: params[:creator] })

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
        playlists = playlists.sort_by { |playlist| playlist.favorites.length }.reverse
        ids = playlists.map(&:id)
        playlists = Playlist.in_order_of(:id, ids)

      # お気に入り登録が少ない順
      elsif params[:order] == "fav_asc"
        playlists = playlists.sort_by { |playlist| playlist.favorites.length }
        ids = playlists.map(&:id)
        playlists = Playlist.in_order_of(:id, ids)

      # 日付の新しい順
      elsif params[:order] == "date_desc"
        playlists = playlists.sort_by{ |playlist| playlist.created_at }.reverse
        ids = playlists.map(&:id)
        playlists = Playlist.in_order_of(:id, ids)

      # 日付の古い順
      elsif params[:order] == "date_asc"
        playlists = playlists.sort_by{ |playlist| playlist.created_at }
        ids = playlists.map(&:id)
        playlists = Playlist.in_order_of(:id, ids)

      # 指定なし(お気に入り登録が多い順)
      else
        playlists = playlists.sort_by { |playlist| playlist.favorites.length }.reverse
        ids = playlists.map(&:id)
        playlists = Playlist.in_order_of(:id, ids)
      end

      if playlists.empty?
        @playlists = playlists
        @playlists_all_page = playlists
      else
        @playlists = playlists.paginate(page: params[:page], per_page: 20)
        @playlists_all_page = playlists
      end
    end
end
