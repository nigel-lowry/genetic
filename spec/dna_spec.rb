require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dna do
  its('phrase.length') { should == "to be or not to be".length }

  describe "#fitness" do
    it "evaluates fitness with a score of how many letters are right" do
      subject.stub(:phrase).and_return('to be or not xxxx')
      subject.fitness.should == '13/18'.to_r
    end
  end
end