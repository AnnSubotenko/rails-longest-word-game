require "open-uri"

class GamesController < ApplicationController
  def new
    # @letters = @letters.rand('A'..'Z')
    @letters = 10.times.map { ('a'..'z').to_a.sample.capitalize }
    @random_letters = @letters.join(' ')
  end

  # def <score></score>
  #   @word = params[:userinput]
  #   @random_letters = params[:random_letters]

  #   if @word.include?@random_letters
  #     @system_answer = "Sorry but #{@word} can't be built out of #{@random_letters}"
  #   elsif @random_letters == @letters
  #     @system_answer = "Congratulations! #{@word} ia s valid English word!"
  #   else
  #     @system_answer = "Sorry but #{@word} does not seem to be a valid English word..."
  #   end
  # end

  def word_valid?(word, letters)
    word.upcase.chars.all? { |char| letters.include?(char) }
    # word.chars.all? { |letters| @word.count(letter) <= @random_letters.count(letters) }
  end

  def valid_english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    @word = params[:userinput]
    @random_letters = params[:random_letters]

    if word_valid?(@word, @random_letters)
      @system_answer = "Congratulations! #{@word} is a valid English word!"
    elsif !word_valid?(@word, @random_letters)
      @system_answer = "Sorry but #{@word} can't be built out of #{@random_letters}"
    else
      @system_answer = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
