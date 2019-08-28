class Prompt < ApplicationRecord
  include API
  has_many :posts, dependent: :destroy

  validates :movie_a, presence:true
  validates :movie_b, presence:true

  def self.random_prompt
    movies_array = File.foreach('movies.txt').map { |line| line.split(", \n") }
    random_movie = movies_array[rand(0..(movies_array.length-1))]
    @movies = []

    response1 = API::Interface.call_by_title(random_movie)
    movie1 = JSON.parse(response1)
    @movies.push(movie1)
    movie2 = find_similar_movie(movie1)
    length = movie2["results"][0]["known_for"].length
    movie2 = movie2["results"][0]["known_for"][rand(0..(length-1))]["title"]
    response2 = API::Interface.call_by_title(movie2)
    movie2 = JSON.parse(response2)
    @movies.push(movie2)
    return @movies
  end

  def self.manual_prompt(movie_one, movie_two)
    response_one = API::Interface.call_by_title(movie_one)
    response_two = API::Interface.call_by_title(movie_two)
    response_one = JSON.parse(response_one)
    response_two = JSON.parse(response_two)

    @prompt = [response_one, response_two]
  end

end

private

def find_similar_movie(movie)
  actors = movie["Actors"]
  response2 = API::Interface.call_by_actor(actors)
  response2 = JSON.parse(response2)
end
