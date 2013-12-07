require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Population do

  describe "#initialize" do
    it "takes target_phrase, mutation_rate and population" do
      @population = Population.new target_phrase: 'foobar', mutation_rate: 0.05, population: 200
    end

    it "raises error if given bad symbol" do
      expect { Population.new foo: 'abc' }.to raise_error
    end
  end
end