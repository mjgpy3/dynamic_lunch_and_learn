require './foo'

describe Foo do

  describe '#bar' do

    let(:my_thing) { 'foo' }

    it 'returns spameggs' do
      subject.bar.should == 'spameggs'
    end

  end

end
