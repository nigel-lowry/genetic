class Dna
  attr_reader :phrase

  @@ALPHABET = ('a'..'z').to_a + [' ']
  @@TARGET_PHRASE = 'to be or not to be'

  def initialize
    @phrase = @@TARGET_PHRASE.length.times.map { random_letter }.join
  end

private

  def random_letter
    @@ALPHABET.sample
  end
end