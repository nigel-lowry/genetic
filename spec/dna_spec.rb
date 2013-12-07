require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dna do
  describe "#initialize" do
    let(:default_target_phrase) { 'to be or not to be' }

    context "no argument" do
      subject { Dna.new }
      its(:target_phrase) { should == default_target_phrase }
      its(:genes) { should_not == default_target_phrase }
      its('genes.length') { should == default_target_phrase.length }
    end

    context "with genes argument" do
      let(:genes) { 'ab be or not to be' }
      subject { Dna.new genes: genes }
      its(:target_phrase) { should == default_target_phrase }
      its(:genes) { should == genes }
    end

    context "with target_phrase argument" do
      let(:target_phrase) { 'barry butler is a pub landlord' }
      subject { Dna.new target_phrase: target_phrase }
      its(:target_phrase) { should == target_phrase }
      its(:genes) { should_not == target_phrase }
      its('genes.length') { should == target_phrase.length }
    end

    context "with both arguments" do
      context "same length" do
        subject { Dna.new target_phrase: 'abc', genes: 'def' }
        its(:target_phrase) { should == 'abc' }
        its(:genes) { should == 'def' }
      end

      context "different length" do
        it "raises error" do
          expect { Dna.new target_phrase: 'abc', genes: 'defg' }.to raise_error
        end
      end
    end

    it "raises error with unrecognised symbol" do
      expect { Dna.new foo: 'abc' }.to raise_error
    end
  end

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