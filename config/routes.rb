Rails.application.routes.draw do
  get 'genres/index'
  get 'genres/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :games
  resources :game_stores
  get '/games', to: 'games#all_games'
end
