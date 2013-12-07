require 'mathn'
require 'set'

class Population
  attr_reader :target_phrase, :mutation_rate, :population

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    raise unless population.is_a? Fixnum
    raise unless population > 1
    raise unless target_phrase.length > 0
    @target_phrase = target_phrase # TODO can't be empty
    @mutation_rate = mutation_rate # TODO must be between 0 and 1
    @population = population # TODO population must be > 0
  end

  def start
    @current_generation = []
    # TODO should we assign mutation rate too?
    @population.times { @current_generation.push Dna.new target_phrase: target_phrase }
    @generations = 0 # TODO move this to Dna class and eventually display ordinal
  end

  def finished?
    @current_generation.any? { |dna| dna.genes == @target_phrase }
  end

  def best
    @current_generation.max_by &:fitness
  end

  def generate
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

    @generations += 1
  end

private

  def pick_parents_based_on_fitness
    mating_pool = @current_generation.uniq
    return [mating_pool.first, mating_pool.first] if mating_pool.one?

    mum = choose_fit_parent mating_pool
    dad = choose_fit_parent mating_pool - [mum]

    [mum, dad]
  end

  def choose_fit_parent mating_pool
    while true
      sample = mating_pool.sample
      return sample if sample.fitness > rand
    end
  end
end