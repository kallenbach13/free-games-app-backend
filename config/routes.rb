Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :game_stores
  resources :genres
  resources :game_genres
  resources :games
end
