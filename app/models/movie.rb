class Movie < ActiveRecord::Base
    def self.rating_values #gets all available rating values from db
        Movie.uniq.pluck(:rating)
    end
    
    def self.with_ratings(ratings_list) #filters movies according to ratings
        if (ratings_list)
            Movie.where(:rating => ratings_list).all
        else #if no rating filter is provided, return all movies
            Movie.all
        end
    end
end
