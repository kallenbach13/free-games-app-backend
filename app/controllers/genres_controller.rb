class GenresController < ApplicationController
  def index
    genres = Genre.all.sort_by{ |genre| genre.name.downcase }
    render json: genres
  end

  def show
  end
end
