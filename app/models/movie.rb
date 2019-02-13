class Movie < ActiveRecord::Base
    def self.rating_values #gets all available rating values from db
        Movie.uniq.pluck(:rating)
    end
    
    def self.with_ratings(ratings_list) #filters movies according to ratings
        Movie.where(:rating => ratings_list).all
    end
end
