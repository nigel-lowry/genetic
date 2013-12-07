require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Population do

  describe "#initialize" do

    context "setting and getting" do
      subject { Population.new target_phrase: 'foobar', mutation_rate: 0.05, population: 200 }
      its(:target_phrase) { should == 'foobar' }
      its(:mutation_rate) { should == 0.05 }
      its(:population) { should == 200 }
    end

    it "raises error if given bad symbol" do
      expect { Population.new foo: 'abc' }.to raise_error
    end
  end
end