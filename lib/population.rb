class Population
  attr_reader :target_phrase, :mutation_rate, :population

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    @target_phrase = target_phrase
    @mutation_rate = mutation_rate
    @population = population

    dnas = []
    # TODO should we assign mutation rate too?
    population.times { dnas.push Dna.new target_phrase: target_phrase }
    fitnesses = dnas.collect { |dna| dna.fitness }
    mating_pool = []
    finished = false
    generations = 0
    perfect_score = 1
  end
end