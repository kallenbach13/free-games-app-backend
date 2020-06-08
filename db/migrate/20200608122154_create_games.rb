class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :image
      t.string :developer
      t.string :publisher
      t.references :genre
      t.references :game_store

      t.timestamps
    end
  end
end
