require 'test_helper'

require 'erv/gaussian_distribution'

describe ERV::GaussianDistribution do

  let :num_samples { 10000 }

  it 'should require the scale and shape parameters' do
    lambda do
      ERV::GaussianDistribution.new()
    end.must_raise ArgumentError
  end

  let :gd do
    ERV::GaussianDistribution.new(mean: 20.0, sd: 0.5)
  end

  context 'sampling' do

    it 'should allow sampling' do
      gd.sample
    end

  end

  context 'moments' do
    let :samples do
      0.upto(num_samples).collect { gd.sample }
    end

    it 'should have the expected mean' do
      sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
      sample_mean.must_be_within_epsilon gd.mean, 0.05
    end

    it 'should have the expected variance' do
      sample_variance = samples.inject(0.0) {|s,x| s += (x - gd.mean) ** 2 } / num_samples.to_f
      sample_variance.must_be_within_epsilon gd.variance, 0.05
    end

  end

end
