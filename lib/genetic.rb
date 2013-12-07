require "genetic/version"
require 'population'
require 'dna'

module Genetic
  class Driver
    def start
      population = Population.new
      until population.finished?
        puts population.best.genes
        population.generate
      end
    end
  end
end