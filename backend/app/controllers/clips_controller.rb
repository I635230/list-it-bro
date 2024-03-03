class ClipsController < ApplicationController
  before_action :certificated, only: %i[index show]

  # TODO: 流石にBroadcasterとかは予測変換だったり、タグみたいなやつから選んだりする感じで検索できるようにしたくはある

  # 検索結果を表示
  def index
    clips = filter_clips
    clips = apply_term(clips)
    @clips = apply_order(clips)
    render status: :ok, json: @clips
  end

  # 特定のclipを表示
  def show
    @clip = Clip.friendly.find(params[:id])
    render status: :ok, json: @clip
  end

  private

    def filter_clips
      # broadcasterのdispaly_nameでソート
      if !params[:broadcaster].nil?
        clips = Clip.joins(:broadcaster).where(broadcasters: { display_name: params[:broadcaster] })

      # gameタイトルでソート
      elsif !params[:game].nil?
        clips = Clip.joins(:game).where(games: { name: params[:game] })

      # タイトルでソート
      elsif !params[:title].nil?
        # キーワード分割
        keywords = params[:title].split(/[[:blank:]]+/)

        # 初期値
        clips = []

        # AND検索
        keywords.each_with_index do |keyword, i|
          if i == 0
            clips = Clip.where("title LIKE ?", "%#{keyword}%")
          else
            clips = clips & Clip.where("title LIKE ?", "%#{keyword}%")
          end
        end
        clips

      # 指定なし
      else
        clips = Clip.all
      end
    end

    def apply_term(clips)

      # 1週間
      if params[:term] == "week"
        clips = clips.where(clip_created_at: 1.week.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 1カ月
      elsif params[:term] == "month"
        clips = clips.where(clip_created_at: 1.month.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 1年
      elsif params[:term] == "year"
        clips = clips.where(clip_created_at: 1.year.ago.beginning_of_day..Time.zone.today.end_of_day)

      # 指定なし(全期間)
      else
        # pass
      end
      clips
    end

    def apply_order(clips)
      # 視聴数が多い順
      if params[:order] == "view_desc"
        clips = clips.order(view_count: :desc)

      # 視聴数が少ない順
      elsif params[:order] == "view_asc"
        clips = clips.order(view_count: :asc)

      # 日付の新しい順
      elsif params[:order] == "date_desc"
        clips = clips.order(clip_created_at: :desc)

      # 日付の古い順
      elsif params[:order] == "date_asc"
        clips = clips.order(clip_created_at: :asc)

      # 指定なし(視聴数が多い順)
      else
        # pass
      end
      clips = clips.paginate(page: params[:page], per_page: 20)
    end
end
