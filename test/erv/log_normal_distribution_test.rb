require 'test_helper'

require 'erv/lognorm_distribution'

describe ERV::LogNormDistribution do
  # Let's generate some tests for the LogNormDistribution class

  let(:num_samples) { 10_000 }

  it 'should require the mu and sigma parameters' do
    lambda do
      ERV::LogNormDistribution.new
    end.must_raise ArgumentError
  end

  let :lnd do
    ERV::LogNormDistribution.new(mu: 0.0, sigma: 0.25)
  end

  context 'sampling' do
    it 'should allow sampling' do
      lnd.sample
    end
  end

  context 'moments' do
    let :samples do
      0.upto(num_samples).collect { lnd.sample }
    end

    it 'should have the expected mean' do
      sample_mean = samples.inject(0.0) { |s, x| s + x } / num_samples.to_f
      sample_mean.must_be_within_epsilon lnd.mean, 0.05
    end

    it 'should have the expected variance' do
      sample_variance = samples.inject(0.0) { |s, x| s + (x - lnd.mean)**2 } / num_samples.to_f
      sample_variance.must_be_within_epsilon lnd.variance, 0.05
    end
  end
end
