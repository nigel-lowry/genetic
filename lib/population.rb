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

    @generations += 1
    @outcome_to_normalized_fitness = @current_generation.each_with_object({}) {|dna, hash| hash[dna] = dna.fitness / @current_generation.sum(&:fitness) }
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
      child = parents.first.crossover parents.last
      child.mutate
      next_generation.push child
    end

    @current_generation.replace next_generation
  end

  def pick_parents_based_on_fitness
    simulator = Simulator.new @outcome_to_normalized_fitness
    first = simulator.outcome

    if @current_generation.all? {|dna| dna.genes == first.genes }
      [first, simulator.outcome]
    else
      loop do
        second = simulator.outcome
        return [first, second] unless first.genes == second.genes
      end
    end
  end
end