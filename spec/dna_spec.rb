require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dna do
  its('phrase.length') { should == "to be or not to be".length }
end