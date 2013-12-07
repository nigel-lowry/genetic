class Dna
  attr_reader :phrase

  @@CHARACTERS = ('a'..'z').to_a + [' ']

  def initialize
    @phrase = 18.times.map { random_letter }.join
  end

private

  def random_letter
    @@CHARACTERS.sample
  end
end