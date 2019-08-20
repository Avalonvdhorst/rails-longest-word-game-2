require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def new
    letters
  end

  def score
    #raise
    session[:score] = 0 if session[:score].nil?

    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    @included = include_word?(@letters, @word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    wordhash = JSON.parse(open(url).read)
    if wordhash["found"] && @included == true
      @answer = "Congratulations! #{@word} is a perfect word!"
      session[:score] += @word.length
    elsif @included == false
      @answer = "Sorry but that can't be made from the given letters"
    else
      @answer = "Sorry #{@word} does not seem to be a valid English word"
    # elsif include_word?(@letters, @word) == false
    #   @answer = "Sorry but that can't be made from the given letters"
    # else
    #   @answer = "Sorry #{@word} does not seem to be a valid English word"
    end
  end

  def include_word?(letters, word)
    word.chars.all? { |letter| letters.include?(letter) }
  end

  private

  def letters
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
    # @letters = ('A'..'Z').to_a.sample(10)
  end
end
