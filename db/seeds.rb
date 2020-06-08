# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

steam = GameStore.create(name: "Steam")
gog = GameStore.create(name: "GOG")

steam_response = RestClient.get("http://api.steampowered.com/ISteamApps/GetAppList/v0002/")
steam_result = JSON.parse(steam_response.body)
steam_result["applist"]["apps"].each do |game|
    steam_second_response = RestClient.get("https://store.steampowered.com/api/appdetails?appids=#{game["appid"]}")
    steam_second_result = JSON.parse(second_response.body)
    byebug
    if  steam_second_result["#{game["appid"]}"]["data"]["is_free"] do
        Game.create(title: steam_second_result["#{game["appid"]}"]["data"]["name"], image: steam_second_result["#{game["appid"]}"]["data"]["header_image"], developer: steam_second_result["#{game["appid"]}"]["data"]["developers"][0], publisher: steam_second_result["#{game["appid"]}"]["data"]["publishers"][0], game_store_id: steam.id)
    end
    
     
end





