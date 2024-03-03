Rails.application.routes.draw do
  scope :api do
    get "/get_games", to: "twitches#get_games"
    post "/get_clips", to: "twitches#get_clips"
    post "/get_clip_broadcaster", to: "twitches#get_clip_broadcaster"
    # resources :users, only: %i[]
    resources :broadcasters, only: %i[create]
    resources :authentications, only: %i[create]
    resources :playlists, only: %i[index show create update destroy] do
      member do
        post "clips/:clip_id", to: "playlists#add_clip", as: "clip"
        put "clips/:clip_id", to: "playlists#order_clip"
        delete "clips/:clip_id", to: "playlists#remove_clip"
      end
    end
    resources :clips, only: %i[index show]
  end
end
