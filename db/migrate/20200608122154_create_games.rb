class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :image
      t.string :developer
      t.string :publisher
      t.string :url
      t.references :game_store
      t.string :api_id

      t.timestamps
    end
  end
end

