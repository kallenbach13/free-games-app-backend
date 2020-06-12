class GamesController < ApplicationController

    def index
      games = Game.all_games.sort_by!{ |game| game.title.downcase }
      render json: games, include: [:genres]
    end

end
