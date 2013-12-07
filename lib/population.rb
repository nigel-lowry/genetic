class Population
  attr_reader :target_phrase, :mutation_rate, :population

  def initialize target_phrase: 'to be or not to be', mutation_rate: 0.01, population: 100
    @target_phrase = target_phrase
    @mutation_rate = mutation_rate
    @population = population
  end
end