Rails.application.routes.draw do
  scope :api do
    get "/get_clips", to: "twitches#get_clips"
  end
end
