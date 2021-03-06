require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Population do

  describe "#initialize" do

    context "with values" do
      subject { Population.new target_phrase: 'foobar', mutation_rate: 0.05, population: 200 }
      its(:target_phrase) { should == 'foobar' }
      its(:mutation_rate) { should == 0.05 }
      its(:population) { should == 200 }
    end

    context "without values" do
      subject { Population.new }
      its(:target_phrase) { should == 'to be or not to be' }
      its(:mutation_rate) { should == 0.01 }
      its(:population) { should == 100 }
    end

    it "raises error if given bad symbol" do
      expect { Population.new foo: 'abc' }.to raise_error
    end

    it "raises error if population is negative" do
      expect { Population.new population: -1 }.to raise_error
    end

    it "raises error if population is zero" do
      expect { Population.new population: 0 }.to raise_error
    end

    it "raises error if population is one" do
      expect { Population.new population: 1 }.to raise_error
    end

    it "doesn't error if population is two" do
      expect { Population.new population: 2 }.to_not raise_error
    end

    it "raises error if population is float" do
      expect { Population.new population: 2.5 }.to raise_error
    end

    it "raises error if target_phrase is empty" do
      expect { Population.new target_phrase: ''}.to raise_error
    end

    it "raises error if target_phrase is nil" do
      expect { Population.new target_phrase: nil}.to raise_error
    end

    it "raises error if target_phrase is not a string" do
      expect { Population.new target_phrase: 55}.to raise_error
    end

    it "raises error if mutation_rate is negative" do
      expect { Population.new mutation_rate: -0.1}.to raise_error
    end

    it "doesn't error if mutation_rate is zero" do
      expect { Population.new mutation_rate: 0.0}.to_not raise_error
    end

    it "doesn't error if mutation_rate is in range" do
      expect { Population.new mutation_rate: 0.15}.to_not raise_error
    end

    it "doesn't error if mutation_rate is one" do
      expect { Population.new mutation_rate: 1.0}.to_not raise_error
    end

    it "raises error if mutation_rate is more than one" do
      expect { Population.new mutation_rate: 1.1}.to raise_error
    end
  end
end