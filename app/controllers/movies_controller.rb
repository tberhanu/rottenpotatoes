class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
  
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end
  
  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "Movie with title called #{@movie.title} is just created successfully."
    redirect_to movies_path
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end 
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie with title '#{@movie.title}' just deleted from the list successfully."
    redirect_to movies_path
  end 
  
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params) #here we need the whole hash of attributes
    flash[:notice] = "You successfully updated movie with title '#{@movie.title}'."
    redirect_to movie_path(@movie)
  end
  private
  
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    
  
end
