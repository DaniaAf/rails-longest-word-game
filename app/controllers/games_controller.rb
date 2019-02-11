require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
      @letters = []
    i = 0
    until i == 10
      @letters << ("A".."Z").to_a.sample
      i += 1
    end
    return @letters
  end

  def in_the_grid
  @word = params[:word].upcase.chars
  @letters = params[:letters]
  array = []
  @word.each do |char|
    if @letters.count(char) >= @word.count(char)
      array << true
    else array << false
    end
  end
    array.all?
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    content_url_word = open(url).read
    result_url = JSON.parse(content_url_word)
    # result_url["found"]

    if @word.blank?
      @score = "type a word please"
    elsif in_the_grid == false
      @score = "The word #{@word.join} can't be built out of the original grid"
    elsif result_url["found"] == false
      @score = "Sorry, #{@word.join} is not a valid English word"
    else
      @score = "Congrat's #{@word.join} is valid English word !"
    end
  end
end
