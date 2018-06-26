require 'rest-client'
require 'json'
require 'pry'

def correct_url?(url, character)
  character_hash = RestClient.get(url)
  character_hash = JSON.parse(character_hash)
  character_list = character_hash["results"].map do |individual_character|
    individual_character["name"].downcase
  end
  character_list.include?(character.downcase)
end

def get_correct_url(character)
  counter = 1
  url = "https://swapi.co/api/people/?page=#{counter}"
  until correct_url?(url, character)
    counter +=1
    url = "https://swapi.co/api/people/?page=#{counter}"
  end
  url
end

def get_individual_character_hash(character)
  url = get_correct_url(character)
  character_hash = RestClient.get(url)
  character_hash = JSON.parse(character_hash)
  character_hash["results"].find do |individual_character|
    individual_character["name"].downcase == character
  end
end

def get_character_movies_from_api(character)
  #make the web request
  individual_character_hash = get_individual_character_hash(character)
  individual_character_hash["films"]
end


def parse_character_movies(films)
  films.each do |movie|
    movie_hash = RestClient.get(movie)
    movie_hash = JSON.parse(movie_hash)
    puts movie_hash["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  parse_character_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
