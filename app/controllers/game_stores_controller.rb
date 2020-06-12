class GameStoresController < ApplicationController
  def index
    game_stores = GameStore.all
    render json: game_stores
  end

  def show
  end
end
