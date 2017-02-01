require 'test_helper'

require 'erv/mixture_distribution'

describe ERV::MixtureDistribution do
  it 'should require at least two distributions' do
    lambda do
      ERV::MixtureDistribution.new([ { distribution: :exponential, rate: 1.0, weight: 0.5 } ])
    end.must_raise ArgumentError
  end

  let :md do
    ERV::MixtureDistribution.new([ { distribution: :exponential, rate: 1.0, weight: 0.3 },
                                   { distribution: :exponential, rate: 2.0, weight: 0.2 },
                                   { distribution: :exponential, rate: 3.0, weight: 0.5 } ])
  end

  context 'sampling' do

    it 'should allow sampling from the mixture' do
      md.sample
    end

  end

  context 'moments' do

    context 'with default amplitude' do
      let :md_expected_mean do
        0.3 * 1/1.0 + 0.2 * 1/2.0 + 0.5 * 1/3.0
      end

      let :md_expected_variance do
        0.3 * ((1/1.0 - md_expected_mean) ** 2 + (1/1.0) ** 2) +
        0.2 * ((1/2.0 - md_expected_mean) ** 2 + (1/2.0) ** 2) +
        0.5 * ((1/3.0 - md_expected_mean) ** 2 + (1/3.0) ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        md.mean.must_equal md_expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        md.variance.must_equal md_expected_variance
      end
    end

    context 'with different amplitudes' do
      let :amd do
        ERV::MixtureDistribution.new([ { distribution: :gaussian, amplitude: 3.0, mean: 1.0, sd: 0.1, weight: 0.3 },
                                       { distribution: :gaussian, amplitude: 5.0, mean: 2.0, sd: 0.2, weight: 0.2 },
                                       { distribution: :gaussian, amplitude: 7.0, mean: 3.0, sd: 0.3, weight: 0.5 } ])
      end

      let :amd_expected_mean do
        0.3 * 3.0 * 1.0 +
        0.2 * 5.0 * 2.0 +
        0.5 * 7.0 * 3.0
      end

      let :amd_expected_variance do
        0.3 * ((3.0 * 1.0 - amd_expected_mean) ** 2 + (3.0 * 0.1) ** 2) +
        0.2 * ((5.0 * 2.0 - amd_expected_mean) ** 2 + (5.0 * 0.2) ** 2) +
        0.5 * ((7.0 * 3.0 - amd_expected_mean) ** 2 + (7.0 * 0.3) ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        amd.mean.must_equal amd_expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        amd.variance.must_equal amd_expected_variance
      end
    end

    context 'with unnormalized weights' do
      let :uwmd do
        ERV::MixtureDistribution.new([ { distribution: :exponential, rate: 1.0, weight: 300 },
                                       { distribution: :exponential, rate: 2.0, weight: 200 },
                                       { distribution: :exponential, rate: 3.0, weight: 500 } ])
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

    end

  end

end
