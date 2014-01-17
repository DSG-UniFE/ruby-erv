require 'spec_helper'

require 'erv/constant_distribution'

describe ERV::ConstantDistribution do

  it 'should require a reference value' do
    lambda do
      ERV::ConstantDistribution.new
    end.should raise_error
  end

  context 'reference value' do

    it 'should be accepted at initialization time' do
      lambda do
        ERV::ConstantDistribution.new(value: 10)
      end.should_not raise_error
    end

    it 'should match the value returned by sampling' do
      val = rand(100)
      crv = ERV::ConstantDistribution.new(value: val)
      crv.sample.should == val
    end

  end

end
