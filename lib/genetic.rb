require 'genetic/version'
require 'population'
require 'dna'

module Genetic
  class Driver
    def start
      population = Population.new
      population.start

      until population.finished?
        puts "#{population.generations} #{population.best}"
        population.generate
      end
    end
  end
end