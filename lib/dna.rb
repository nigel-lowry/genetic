require 'mathn'
require 'set'
require 'active_support/all'

class Dna
  attr_reader :genes, :target_phrase

  @@ALPHABET = ('a'..'z').to_a + [' ']
  @@MUTATION_RATE = 0.01 # TODO pass in

  def initialize target_phrase: 'to be or not to be', genes: target_phrase.length.times.map { random_letter }.join
    raise unless target_phrase.length == genes.length
    raise unless target_phrase.chars.to_set.subset? @@ALPHABET.to_set
    @target_phrase = target_phrase
    @genes = genes
  end

  def fitness
    2 ** number_of_characters_in_correct_position
  end

  def number_of_characters_in_correct_position
    number_of_letters_in_correct_position = 0

    @genes.chars.each_index do |index|
      number_of_letters_in_correct_position += 1 if character_in_correct_position? index
    end

    number_of_letters_in_correct_position
  end

  def crossover partner
    Dna.new genes: @genes.chars.each_index { |index| [self, partner].sample.genes[index] }.join, target_phrase: @target_phrase
  end

  def mutate
    @genes.chars.each_index do |index|
      @genes[index] = random_letter if mutant_gene?
    end
  end

  def to_s
    "'#{genes}' = #{fitness}"
  end

private

  def random_letter
    @@ALPHABET.sample
  end

  def character_in_correct_position? index
    target_phrase[index] == genes[index]
  end

  def mutant_gene?
    rand < @@MUTATION_RATE
  end
end