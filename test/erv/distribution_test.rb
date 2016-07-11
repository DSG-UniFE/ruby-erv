require 'test_helper'

# require 'erv/distribution'

describe ERV::Distribution do

  it 'should raise an error in case no seed or RNG are provided' do
    lambda do
      ERV::Distribution.new(something: :useless)
    end.must_raise ArgumentError
  end

end
