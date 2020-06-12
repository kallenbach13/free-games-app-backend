# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

steam = GameStore.find_or_create_by(name: "Steam")
gog = GameStore.find_or_create_by(name: "GOG")

other_genre = Genre.find_or_create_by(name: "Other")


instance_count = 0
if Game.all.count === 0
    puts "Fetching all Steam games"
    steam_response = RestClient.get("http://api.steampowered.com/ISteamApps/GetAppList/v0002/")
    steam_result = JSON.parse(steam_response.body)
    
    puts "Total games to look through: " + steam_result["applist"]["apps"].length.to_s
    steam_result["applist"]["apps"].each do |game|        
        game_id = game["appid"].to_s 
        new_game = Game.create(game_store_id: steam.id, api_id: game_id, url: "https://store.steampowered.com/app/" + game_id)
        instance_count += 1
        puts "Created Instance " + instance_count.to_s
    end
end

gog_response = RestClient.get("https://embed.gog.com/games/ajax/filtered?price=free&hide=dlc")
gog_result = JSON.parse(gog_response.body)

if !Game.find_by(title: gog_result["products"][-1]["title"])
    gog_result["products"].each do |game|
    
      game_instance = Game.create(
          title: game["title"],
          image: game["image"],
          developer: game["developer"],
          publisher: game["publisher"],
          url: "https://www.gog.com" + game["url"], 
          game_store_id: gog.id
      )
      
      if game["genres"].length > 0
          game["genres"].each do |genre_name|
            
          genre = Genre.find_or_create_by(name: genre_name)
              
          GameGenre.create(game: game_instance, genre: genre)
        end
        else
          GameGenre.create(game: game_instance, genre: other_genre)
        end
  end
end

puts "Updating individual games"
steam.games.each do |game|
    if !game.title
        steam_second_response = RestClient.get("https://store.steampowered.com/api/appdetails?appids=#{game.api_id}")
        steam_second_result = JSON.parse(steam_second_response.body)

        if steam_second_result[game.api_id]["success"] && steam_second_result[game.api_id]["data"]["is_free"]
            game_info = steam_second_result[game.api_id]["data"]
            
            game_developer = game_info["developers"] ? game_info["developers"][0] : nil
            game_publisher = game_info["publishers"] ? game_info["publishers"][0] : nil
            
            game.update(
                title: game_info["name"],
                image: game_info["header_image"],
                developer: game_developer,
                publisher: game_publisher,
                game_store_id: steam.id
            )
                
            if steam_second_result[game.api_id]["data"]["genres"]
                steam_second_result[game.api_id]["data"]["genres"].each do |genre|
                    genre = Genre.find_or_create_by(name: genre["description"])
                    
                    GameGenre.create(game: game, genre: genre)
                end
            else
                GameGenre.create(game:game, genre: other_genre)
            end

            puts "Updated individual game. ID: " + game.id.to_s
        else
            game.destroy
            puts "Deleted individual game. ID: " + game.id.to_s
        end
    end
end
    