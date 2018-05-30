require 'test_helper'

require 'erv/exponential_distribution'

describe ERV::ExponentialDistribution do

  let (:num_samples) { 10000 }

  it 'should require the rate parameter' do
    lambda do
      ERV::ExponentialDistribution.new()
    end.must_raise ArgumentError
  end

  let :ed do
    ERV::ExponentialDistribution.new(rate: 20.0)
  end

  context 'sampling' do

    it 'should allow sampling' do
      ed.sample
    end

  end

  context 'moments' do
    let :samples do
      0.upto(num_samples).collect { ed.sample }
    end

    it 'should have the expected mean' do
      sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
      sample_mean.must_be_within_epsilon ed.mean, 0.05
    end

    it 'should have the expected variance' do
      sample_variance = samples.inject(0.0) {|s,x| s += (x - ed.mean) ** 2 } / num_samples.to_f
      sample_variance.must_be_within_epsilon ed.variance, 0.05
    end

  end

end
