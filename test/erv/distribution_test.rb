require 'test_helper'

require 'erv/distribution'

describe ERV::Distribution do

  context 'when explicitly given an RNG' do

    it 'should use the given RNG' do
      rng = Random.new
      d = ERV::Distribution.new(rng: rng)
      d.instance_variable_get(:@rng).must_equal rng
    end

  end

end
