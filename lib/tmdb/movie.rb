require 'tmdb/attributes'
require 'tmdb/null_movie'

module TMDb
  class Movie
    extend Attributes

    tmdb_attr :adult
    tmdb_attr :backdrop_path
    tmdb_attr :belongs_to_collection
    tmdb_attr :budget
    tmdb_attr :genres#
    tmdb_attr :homepage
    tmdb_attr :id
    tmdb_attr :imdb_id
    tmdb_attr :original_title
    tmdb_attr :overview
    tmdb_attr :popularity
    tmdb_attr :poster_path
    tmdb_attr :production_companies#
    tmdb_attr :production_countries#
    tmdb_attr :release_date
    tmdb_attr :revenue
    tmdb_attr :runtime
    tmdb_attr :spoken_languages#
    tmdb_attr :status
    tmdb_attr :tagline
    tmdb_attr :title
    tmdb_attr :vote_average
    tmdb_attr :vote_count

    def initialize(args)
      @tmdb_attrs = args
    end

    # Returns the movie with TMDb id of +id+.
    #
    def self.find(id)
      begin
        response = TMDb.get_api_response("movie/#{id}")
        new(response)
      rescue ServiceUnavailable
        TMDb.configuration.null_movie || raise
      end
    end

    # Returns an enumerable containing all the movies matching the
    # condition hash. Currently the only condition that can be specified
    # is name, e.g.
    #
    #   movies = Movie.where(:name => 'Reeves')
    #
    # Only the first page of results (20 people) are returned.
    #
    def self.where(args)
      response = TMDb.get_api_response('search/movie', :query => args[:name])
      response['results'].map {|attrs| new(attrs) }
    end

    # Returns a URL for the movies's poster image at the given +size+. Valid
    # sizes should be discovered via the +Configuration.image_profile_sizes+
    # method. Returns nil if the movie does not have a poster image.
    #
    def poster_image_url(size)
      if profile_path
        [TMDb.configuration.image_base_url, size, poster_path].join
      end
    end
  end
end
