require 'test_helper'

require 'erv/geometric_distribution'

describe ERV::GeometricDistribution do

  NUM_SAMPLES = 10000

  it 'should require at least a probability of success parameter' do
    lambda do
      ERV::GeometricDistribution.new()
    end.must_raise ArgumentError
  end

  let :gd do
    ERV::GeometricDistribution.new(probability_of_success: 0.5)
  end

  context 'sampling' do

    it 'should allow sampling' do
      gd.sample
    end

  end

  context 'moments' do
    let :samples do
      0.upto(NUM_SAMPLES).collect { gd.sample }
    end

    it 'should have the expected mean' do
      sample_mean = samples.inject(0.0) {|s,x| s += x } / NUM_SAMPLES.to_f
      sample_mean.must_be_within_epsilon gd.mean, 0.05
    end

    it 'should have the expected variance' do
      sample_variance = samples.inject(0.0) {|s,x| s += (x - gd.mean) ** 2 } / NUM_SAMPLES.to_f
      sample_variance.must_be_within_epsilon gd.variance, 0.05
    end

  end

end
