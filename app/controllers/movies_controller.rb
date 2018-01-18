class MoviesController < ApplicationController
  def index
    
    if params[:sort] == 'title'
      @movies = Movie.all.sort_by { |movie| movie.title.downcase}
      @bright1 = 'hilite'
      
    elsif params[:sort] == 'rating'
      @movies = Movie.all.sort_by { |movie| movie.rating.downcase}
      @bright2 = 'hilite'
      
    elsif params[:sort] == 'release_date'
      @movies = Movie.all.sort_by { |movie| movie.release_date}
      @bright3 = 'hilite'
    
    else
      @movies = Movie.all
    end
    
    @all_ratings = Movie.all_ratings
    @default_rating_value = Hash[@all_ratings.map {|rating| [rating, "1"]}]
    @selected_rating_value = params[:hash] || session[:hash] || @default_rating_value
    session[:hash] = @selected_rating_value
    
    @movies = @movies.select { |movie| @selected_rating_value.include?(movie.rating)}
    
  end
  
  def show
    id = params[:id]
    @movie = Movie.find(id)
  end
  
  def new
    @movie = Movie.new
  end
  
  def create
    # @movie = Movie.create!(movie_params)
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Movie with title called #{@movie.title} is just created successfully."
      redirect_to movies_path
    else
      render 'new'
    end
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
    # @movie.update_attributes!(movie_params) #here we need the whole hash of attributes
    if @movie.update_attributes(movie_params)
      flash[:notice] = "You successfully updated movie with title '#{@movie.title}'."
      redirect_to movie_path(@movie)
    else 
      render 'edit'
    end
  end
  
  private
  
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    
  
end
