require 'mathn'
require 'active_support/all'

class Dna
  attr_reader :genes, :target_phrase

  @@ALPHABET = ('a'..'z').to_a + [' ']
  @@MUTATION_RATE = 0.01

  def initialize options={}
    assert_valid_keys options
    assign_target_phrase_and_genes options
    assert_same_length
  end

  def fitness
    number_of_letters_in_correct_position = 0

    @genes.chars.each_index do |index|
      number_of_letters_in_correct_position += 1 if character_in_correct_position? index
    end

    number_of_letters_in_correct_position / @target_phrase.length
  end

  def crossover partner
    Dna.new genes: @genes.chars.each_index { |index| [self, partner].sample.genes[index] }.join, target_phrase: @target_phrase
  end

  def mutate
    @genes.chars.each_index do |index|
      @genes[index] = random_letter if rand < @@MUTATION_RATE
    end
  end

private

  def assert_valid_keys options
    options.assert_valid_keys :target_phrase, :genes
  end

  def assign_target_phrase_and_genes(options)
    @target_phrase = options[:target_phrase] || 'to be or not to be'
    @genes = options[:genes] || @target_phrase.length.times.map { random_letter }.join
  end

  def assert_same_length
    raise unless @target_phrase.length == @genes.length
  end

  def random_letter
    @@ALPHABET.sample
  end

  def character_in_correct_position? index
    target_phrase[index] == genes[index]
  end
end