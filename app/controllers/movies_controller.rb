class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    all_rating_keys = Movie.rating_values #get all the ratings that are in the db
    if all_rating_keys #check for nil
      @all_ratings = Hash.new #create the new hash for what will be displayed on the view
      all_rating_keys.each do |rate| 
        @all_ratings[rate] = true #create a tuple of ratings, checked value for display
#what this part of the code does is, if the view is sending back checkbox params
#then set their corresponding checked values as true for display
#otherwise set them as false
        if params[:ratings]
          if params[:ratings][rate] == nil
            @all_ratings[rate] = false
          end
        end
      end
    end
#if the sort params are coming in, then preserve the previous excercise's efforts    
    if params[:sort]
      @movies = Movie.order(params[:sort])
    elsif params[:ratings] #if we are getting ratings as params, filter the results
      ratings_list = params[:ratings].keys
      @movies = Movie.with_ratings(ratings_list)
    else
      @movies = Movie.all
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
