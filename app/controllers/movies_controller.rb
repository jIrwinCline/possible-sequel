class MoviesController < ApplicationController

  include API

    def index
      @prompt = Prompt.find(params[:prompt_id])
      @post = @prompt.post.new
      movie_one = @prompt.movie_a
      movie_two = @prompt.movie_b
      response_one = API::Interface.call(movie_one)
      response_two = API::Interface.call(movie_two)
      @response_one = JSON.parse(response_one)
      @response_two = JSON.parse(response_two)
      @title_one = JSON.parse(response_one)["Title"]
      @title_two = JSON.parse(response_two)["Title"]
      @actors_one = JSON.parse(response_one)["Actors"]
      @actors_two = JSON.parse(response_two)["Actors"]
      @plot_one = JSON.parse(response_one)["Plot"]
      @plot_two = JSON.parse(response_two)["Plot"]
    end

end
