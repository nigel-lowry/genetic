require 'mathn'

class Dna
  attr_reader :genes

  @@ALPHABET = ('a'..'z').to_a + [' ']
  @@TARGET_PHRASE = 'to be or not to be'

  def initialize
    @genes = @@TARGET_PHRASE.length.times.map { random_letter }.join
  end

  def fitness
    number_of_letters_in_correct_position = 0

    @genes.chars.each_index do |index|
      number_of_letters_in_correct_position += 1 if character_in_correct_position? index
    end

    number_of_letters_in_correct_position / @@TARGET_PHRASE.length
  end

private

  def random_letter
    @@ALPHABET.sample
  end

  def character_in_correct_position? index
    @@TARGET_PHRASE[index] == genes[index]
  end
end