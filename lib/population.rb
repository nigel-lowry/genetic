require 'mathn'
require 'set'
require 'simulator'

class Population
  attr_reader :target_phrase, :mutation_rate, :population, :generations

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    raise unless population.is_a? Fixnum
    raise unless population > 1
    raise unless target_phrase.length > 0
    raise unless mutation_rate.in? 0.0..1.0
    @target_phrase = target_phrase
    @mutation_rate = mutation_rate
    @population = population

    @generations = 0
    @current_generation = []
  end

  def finished?
    @current_generation.any? { |dna| dna.genes == @target_phrase }
  end

  def best
    @current_generation.max_by &:fitness
  end

  def generate
    if @generations.zero?
      first_generation
    else
      subsequent_generation
    end

    @total_fitness = @current_generation.sum &:fitness
    @generations += 1
  end

private

  def first_generation
    # TODO should we assign mutation rate too?
    @population.times { @current_generation.push Dna.new target_phrase: target_phrase }
  end

  def subsequent_generation
    next_generation = []

    @population.times do
      parents = pick_parents_based_on_fitness
      mum = parents.first
      dad = parents.last

      child = mum.crossover dad
      child.mutate
      next_generation.push child
    end

    @current_generation.replace next_generation
  end

  def pick_parents_based_on_fitness
    outcome_to_normalized_fitness = {}
    @current_generation.each {|dna| outcome_to_normalized_fitness.store dna, dna.fitness / @total_fitness }
    simulator = Simulator.new outcome_to_normalized_fitness
    [simulator.outcome, simulator.outcome]
  end
end