require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times { @letters << alphabet.sample }
    @letters
  end

  def score
    if !grid_check(params[:guess], params[:letters].split(" "))
      @answer = "Sorry but <strong>#{params[:guess].upcase}</strong> can't be built out of #{params[:letters].upcase.split(" ").join(",")}"
    elsif !word_check(params[:guess])
      @answer = "Sorry but #{params[:guess].upcase} does not seem to be a valid English word..."
    else
      @answer = "Congratulations! #{params[:guess].upcase} is a valid English word!"
    end
  end

  private

  def grid_check(word, grid)
    grid_downcased = grid.map(&:downcase)
    word_downcased_letters = word.downcase.chars
    word_downcased_letters.all? { |a| word_downcased_letters.count(a) <= grid_downcased.count(a) }
  end

  def word_check(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word_infos = JSON.parse(word_serialized)
    return word_infos["found"]
  end

  # def run_game(attempt, grid, start_time, end_time)
  #   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
  #   score = 0
  #   if !word_check(attempt)
  #     message = "not an english word"
  #   elsif !grid_check(attempt, grid)
  #     message = "not in the grid"
  #   else
  #     score = score(attempt, start_time, end_time)
  #     message = "Well Done!"
  #   end
  #   return { score: score, message: message, time: time_taken(start_time, end_time) }
  # end

  # # test if attempt is in the dictionary, return the hash if true nil else to use as boolean



  # check that attempt contains the letter in the grid only once (remove the letter checked each time)




  # # if word not a word (test_word returns nil) puts "the word does not exist"
  # # if grid_test returns false then puts "letters are not in the grid"
  # def error_message(word)
  #   return "not an english word" unless word_check(word)
  #   return "not in the grid" unless grid_check(word)
  # end

  # # compute a score
  # def score(word, start_time, end_time)
  #   word.length / time_taken(start_time, end_time)
  # end

  # def time_taken(start_time, end_time)
  #   end_time - start_time
  # end


end

# raise
# array dans array sans doublon
# comment envoyer l'array dans le post
