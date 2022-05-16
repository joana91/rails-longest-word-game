require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array('a'..'z')
    @letters = Array.new(10) { charset.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    if params[:letters].chars.sort.join.downcase =~ Regexp.new(params[:word].chars.sort.join('.*'))
      @message = 'Great'
      if user['found']
        @message = 'The word is valid according to the grid and is an English word'
      else
        @message = 'The word is valid according to the grid, but is not a valid English word'
      end
    else
      @message = "The word can't be built out of the original grid"
    end
  end
end
