require 'test_helper'
require 'erv/expnorm_distribution'

describe ERV::ExpNormDistribution do
  let(:num_samples) { 10_000 }

  context 'initialization' do
    it 'requires mu, sigma and lambda' do
      -> { ERV::ExpNormDistribution.new }.must_raise ArgumentError
      -> { ERV::ExpNormDistribution.new(mu: 0, sigma: 1) }.must_raise ArgumentError
    end

    it 'raises on invalid parameters' do
      -> { ERV::ExpNormDistribution.new(mu: 0, sigma: 0, lambda: 1) }.must_raise ArgumentError
      -> { ERV::ExpNormDistribution.new(mu: 0, sigma: 1, lambda: -1) }.must_raise ArgumentError
    end
  end

  let(:expn) { ERV::ExpNormDistribution.new(mu: 10.0, sigma: 5.0, lambda: 0.2) }

  context 'sampling' do
    it 'allows sampling and returns positive values' do
      sample = expn.sample
      sample.must_be :>, 0
    end
  end

  context 'moments' do
    let(:samples) { num_samples.times.map { expn.sample } }

    it 'has correct mean' do
      sample_mean = samples.sum / num_samples.to_f
      sample_mean.must_be_within_epsilon expn.mean, 0.05 # 10 + 1/0.2 = 15
    end

    it 'has correct variance' do
      sample_var = samples.inject(0.0) { |s, x| s + (x - expn.mean)**2 } / num_samples.to_f
      sample_var.must_be_within_epsilon expn.variance, 0.05 # 25 + 25 = 50
    end
  end
end
