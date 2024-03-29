class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
   @all_ratings = Movie.ratings
   @selected_ratings = session[:selected_ratings]
   @commit = params[:commit]
   
   commit = params[:commit]
   if commit then
    @selected_ratings = params.fetch(:ratings, {}).keys
    session[:selected_ratings] = @selected_ratings
   end
   if session[:selected_ratings].blank?
    session[:selected_ratings] = @all_ratings
    @selected_ratings = @all_ratings
   end

   @movies = Movie.where("rating in (?)", session[:selected_ratings])

   if(params.has_key?(:sort))
   @movies = @movies.order(sort_column + " " + sort_direction)
   
   else
   @movies
   end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def sort_column
    params[:sort]
  end

  def sort_direction
    params[:direction]
  end

end
