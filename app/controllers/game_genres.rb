class GameGenresController < ApplicationController
  def index
      game_genres = GameGenre.all
      render json: game_genres
  end
  
  def show
  end
end