require 'open-uri'

class GamesController < ApplicationController
  def new
    # The word can't be built out of the original grid
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # The word is valid according to the grid, but is not a valid English word
    # The word is valid according to the grid and is an English word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:user_input]}"
    word_verification = open(url).read
    file = JSON.parse(word_verification)

    params[:user_input].split(//).each do |letter|
      if params[:letters].include?(letter) && file['found'] == true
        return @result = "Congratulations, #{params[:user_input]} is a valid English word."
      elsif params[:letters].include?(letter) && file['found'] == false
        return @result = "Sorry but '#{params[:user_input]}' does not seem to be a valid English word."
      else
        return @result = "Sorry but '#{params[:user_input]}' can't be built out of #{params[:letters].split(" ").join(", ")}."
      end
    end
  end
end
