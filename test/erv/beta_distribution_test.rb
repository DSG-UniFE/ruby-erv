require 'test_helper'

require 'erv/beta_distribution'

describe ERV::BetaDistribution do
  let :num_samples do
    10_000
  end

  context 'initialization' do
    it 'should require the alpha and beta parameters' do
      -> { ERV::BetaDistribution.new(alpha: 0.0) }.must_raise ArgumentError
      -> { ERV::BetaDistribution.new(beta: 0.0) }.must_raise ArgumentError
      -> { ERV::BetaDistribution.new(alpha: -1.0, beta: 0.0) }.must_raise ArgumentError
      -> { ERV::BetaDistribution.new(alpha: 0.0, beta: -1.0) }.must_raise ArgumentError
    end
  end
  let :bd do
    ERV::BetaDistribution.new(alpha: 2.0, beta: 5.0)
  end

  context 'sampling' do
    it 'should allow sampling' do
      bd.sample
    end
  end

  context 'moments' do
    let :samples do
      0.upto(num_samples).collect { bd.sample }
    end

    it 'should have the expected mean' do
      sample_mean = samples.inject(0.0) { |s, x| s + x } / num_samples.to_f
      sample_mean.must_be_within_epsilon bd.mean, 0.05
    end

    it 'should have the expected variance' do
      samples.inject(0.0) { |s, x| s + (x - bd.mean)**2 } / num_samples.to_f
    end
  end
end
