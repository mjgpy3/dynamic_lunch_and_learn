require './foo'

describe Foo do

  describe '#bar' do

    it 'returns spameggs' do
      subject.bar.should == 'spameggs'
    end

  end

end
