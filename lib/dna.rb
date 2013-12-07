require 'mathn'

class Dna
  attr_reader :phrase

  @@ALPHABET = ('a'..'z').to_a + [' ']
  @@TARGET_PHRASE = 'to be or not to be'

  def initialize
    @phrase = @@TARGET_PHRASE.length.times.map { random_letter }.join
  end

  def fitness

    number_of_letters_in_correct_position = 0

    @phrase.chars.each_index do |index|
      number_of_letters_in_correct_position += 1 if @@TARGET_PHRASE[index] == phrase[index]
    end

    number_of_letters_in_correct_position / @@TARGET_PHRASE.length
  end

private

  def random_letter
    @@ALPHABET.sample
  end
end