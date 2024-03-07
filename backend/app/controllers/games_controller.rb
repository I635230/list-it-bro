class GamesController < ApplicationController
  def index
    render status: :ok, json: Game.all.map(&:name)
  end
end
