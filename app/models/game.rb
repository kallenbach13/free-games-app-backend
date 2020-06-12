class Game < ApplicationRecord
    has_many :game_genres
    has_many :genres, through: :game_genres
    belongs_to :game_store

    def self.all_games
        Game.all.select { |game| game.title }
    end
end
