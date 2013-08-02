module TMDb

  # This class is a Null Object version of the +Movie+ class.
  #
  class NullMovie
    attr_accessor :adult, :backdrop_path, :belongs_to_collection,
    :budget, :genres, :homepage, :id, :imdb_id, :original_title,
    :overview, :popularity, :poster_path, :production_companies,
    :production_countries, :release_date, :revenue, :runtime,
    :spoken_languages, :status, :tagline, :title, :vote_average,
    :vote_count


    attr_writer :poster_image_url

    def poster_image_url(size)
      @poster_image_url
    end
  end
end
