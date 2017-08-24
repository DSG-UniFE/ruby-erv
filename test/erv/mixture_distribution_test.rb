require 'test_helper'

require 'erv/mixture_distribution'

describe ERV::MixtureDistribution do

  let :num_samples { 10000 }

  it 'should require at least two distributions' do
    lambda do
      ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 0.5 } ])
    end.must_raise ArgumentError
  end

  context 'sampling' do

    let :md do
      ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 0.3 },
                                     { distribution: :exponential, args: { rate: 2.0 }, weight: 0.2 },
                                     { distribution: :exponential, args: { rate: 3.0 }, weight: 0.5 } ])
    end

    it 'should allow sampling from the mixture' do
      md.sample
    end

  end

  context 'moments' do

    context 'with normalized weights' do

      let :amd do
        ERV::MixtureDistribution.new([ { distribution: :gaussian, args: { mean: 1.0, sd: 0.1 }, weight: 0.3 },
                                       { distribution: :gaussian, args: { mean: 2.0, sd: 0.2 }, weight: 0.2 },
                                       { distribution: :gaussian, args: { mean: 3.0, sd: 0.3 }, weight: 0.5 } ])
      end

      let :amd_expected_mean do
        0.3 * 1.0 +
        0.2 * 2.0 +
        0.5 * 3.0
      end

      let :amd_expected_variance do
        0.3 * ((1.0 - amd_expected_mean) ** 2 + 0.1 ** 2) +
        0.2 * ((2.0 - amd_expected_mean) ** 2 + 0.2 ** 2) +
        0.5 * ((3.0 - amd_expected_mean) ** 2 + 0.3 ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        amd.mean.must_equal amd_expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        amd.variance.must_equal amd_expected_variance
      end

      let :samples do
        0.upto(num_samples).collect { amd.sample }
      end

      it 'mean of a sample set should match the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon amd.mean, 0.05
      end

      it 'variance of a sample set should match the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - amd.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon amd.variance, 0.05
      end

    end

    context 'with unnormalized weights' do

      let :uwmd do
        ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 300 },
                                       { distribution: :exponential, args: { rate: 2.0 }, weight: 200 },
                                       { distribution: :exponential, args: { rate: 3.0 }, weight: 500 } ])
      end

      let :uwmd_expected_mean do
        0.3 * 1/1.0 + 0.2 * 1/2.0 + 0.5 * 1/3.0
      end

      let :uwmd_expected_variance do
        0.3 * ((1/1.0 - uwmd_expected_mean) ** 2 + (1/1.0) ** 2) +
        0.2 * ((1/2.0 - uwmd_expected_mean) ** 2 + (1/2.0) ** 2) +
        0.5 * ((1/3.0 - uwmd_expected_mean) ** 2 + (1/3.0) ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        uwmd.mean.must_equal uwmd_expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        uwmd.variance.must_equal uwmd_expected_variance
      end

      let :samples do
        0.upto(num_samples).collect { uwmd.sample }
      end

      it 'mean of a sample set should match the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon uwmd.mean, 0.05
      end

      it 'variance of a sample set should match the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - uwmd.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon uwmd.variance, 0.05
      end

    end

  end

  context 'mixture of mixtures' do
    let :momd do
      ERV::MixtureDistribution.new([ { distribution: :mixture,
                                       args: [ { distribution: :exponential, args: { rate: 4.0 }, weight: 300 },
                                               { distribution: :exponential, args: { rate: 5.0 }, weight: 200 },
                                               { distribution: :exponential, args: { rate: 6.0 }, weight: 500 } ],
                                       weight: 200 },
                                     { distribution: :mixture,
                                       args: [ { distribution: :exponential, args: { rate: 7.0 }, weight: 300 },
                                               { distribution: :exponential, args: { rate: 8.0 }, weight: 200 },
                                               { distribution: :exponential, args: { rate: 9.0 }, weight: 500 } ],
                                       weight: 300 },
                                   ], inspect: true)
    end

    it 'should allow sampling from the mixture' do
      momd.sample
    end

  end

end
