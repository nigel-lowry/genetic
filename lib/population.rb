require 'mathn'
require 'simulator'

class Population
  attr_reader :target_phrase, :mutation_rate, :population

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    @target_phrase = target_phrase
    @mutation_rate = mutation_rate
    @population = population

    # TODO population must be > 0

    @dnas = []
    # TODO should we assign mutation rate too?
    @population.times { @dnas.push Dna.new target_phrase: target_phrase }
    @generations = 0
  end

  def generate
    @population.times do
      parents = pick_parents_based_on_fitness
      child = parents.first.crossover parents.second
      child.mutate
      @dnas.push child
    end

    @generations += 1
    @dnas.clear
  end

  def pick_parents_based_on_fitness
    mating_pool = []

    @dnas.each do |dna|
      n = (dna.fitness * 100).to_i
      n.times { mating_pool.push dna }
    end

    mating_pool.sample 2
  end

  def best
    @dnas.max_by &:fitness
  end

  def finished?
    @dnas.any? { |dna| dna.genes == @target_phrase }
  end
end