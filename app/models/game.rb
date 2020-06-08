class Game < ApplicationRecord
    belongs_to :genre
    belongs_to :game_store
end
