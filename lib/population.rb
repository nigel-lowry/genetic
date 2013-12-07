require 'mathn'
require 'simulator'

class Population
  attr_reader :target_phrase, :mutation_rate, :population

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    @target_phrase = target_phrase
    @mutation_rate = mutation_rate
    @population = population

    @dnas = []
    # TODO should we assign mutation rate too?
    population.times { @dnas.push Dna.new target_phrase: target_phrase }
    @generations = 0
  end

  def generate
    @dnas.clear

    population.times do
      parents = pick_parents_based_on_fitness
      child = parents.first.crossover parents.second
      dnas.push child
    end

    @generations += 1
  end

  def pick_parents_based_on_fitness
    fitness_total = @dnas.sum &:fitness
    scalar = 1.0 / fitness_total

    dna_to_scaled_fitness = {}
    @dnas.each {|dna| dna_to_scaled_fitness.store dna, dna.fitness * scalar }

    simulator = Simulator.new dna_to_scaled_fitness

    # TODO could be the same
    [simulator.outcome, simulator.outcome]
  end

  def best
    @dnas.max_by &:fitness
  end

  def finished?
    @dnas.any? { |dna| dna.genes == @target_phrase }
  end
end