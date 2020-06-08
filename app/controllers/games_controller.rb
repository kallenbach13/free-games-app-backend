require 'pp'
GOG_BASE_URL = "https://embed.gog.com"

class GamesController < ApplicationController

    def all_games
        response = RestClient.get(GOG_BASE_URL + "/games/ajax/filtered?price=free&hide=dlc")
        result = JSON.parse(response.body)
        games = result["products"]
        
        render json: games
    end

end
