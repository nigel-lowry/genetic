require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dna do
  its('genes.length') { should == "to be or not to be".length }

  describe "#fitness" do
    it "is zero when none of the letters are in the right positions" do
      subject.stub(:genes).and_return('xxxxxxxxxxxxxxxxxx')
      subject.fitness.should == 0
    end

    it "is a percentage when some of the letters are right" do
      subject.stub(:genes).and_return('xo be or not to be')
      subject.fitness.should == '17/18'.to_r
    end

    it "is one when all of the letters are in the right positions" do
      subject.stub(:genes).and_return('to be or not to be')
      subject.fitness.should == 1
    end
  end
end