require 'erv/distribution_behaviour'

describe ERV::MixtureDistribution do

  let (:num_samples) { 10000 }

  it 'should require at least two distributions' do
    expect{
      ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 0.5 } ])
    }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) do
      ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 0.3 },
                                     { distribution: :exponential, args: { rate: 2.0 }, weight: 0.2 },
                                     { distribution: :exponential, args: { rate: 3.0 }, weight: 0.5 } ])
    end

    it 'should allow sampling from the mixture' do
      expect{ distribution.sample }.not.to raise_exception(ArgumentError).and(! be_nil)
    end
  end

  with 'moments' do
    with 'with normalized weights' do
      let(:distribution) do
        ERV::MixtureDistribution.new([ { distribution: :gaussian, args: { mean: 1.0, sd: 0.1 }, weight: 0.3 },
                                       { distribution: :gaussian, args: { mean: 2.0, sd: 0.2 }, weight: 0.2 },
                                       { distribution: :gaussian, args: { mean: 3.0, sd: 0.3 }, weight: 0.5 } ])
      end

      let(:expected_mean) do
        0.3 * 1.0 +
        0.2 * 2.0 +
        0.5 * 3.0
      end

      let(:expected_variance) do
        0.3 * ((1.0 - expected_mean) ** 2 + 0.1 ** 2) +
        0.2 * ((2.0 - expected_mean) ** 2 + 0.2 ** 2) +
        0.5 * ((3.0 - expected_mean) ** 2 + 0.3 ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        expect(distribution.mean).to be == expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        expect(distribution.variance).to be == expected_variance
      end

      let(:num_samples) { 200_000 }
      let(:samples) { num_samples.times.map { distribution.sample } }
      let(:epsilon) { 5E-2 }

      include ERV::DistributionBehavior
    end

    with 'with unnormalized weights' do
      let(:distribution) do
        ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 300 },
                                       { distribution: :exponential, args: { rate: 2.0 }, weight: 200 },
                                       { distribution: :exponential, args: { rate: 3.0 }, weight: 500 } ])
      end

      let(:expected_mean) do
        0.3 * 1/1.0 + 0.2 * 1/2.0 + 0.5 * 1/3.0
      end

      let(:expected_variance) do
        0.3 * ((1/1.0 - expected_mean) ** 2 + (1/1.0) ** 2) +
        0.2 * ((1/2.0 - expected_mean) ** 2 + (1/2.0) ** 2) +
        0.5 * ((1/3.0 - expected_mean) ** 2 + (1/3.0) ** 2)
      end

      it 'should correctly calculate the mean of the mixture' do
        expect(distribution.mean).to be == expected_mean
      end

      it 'should correctly calculate the variance of the mixture' do
        expect(distribution.variance).to be == expected_variance
      end

      let(:num_samples) { 200_000 }
      let(:samples) { num_samples.times.map { distribution.sample } }
      let(:epsilon) { 5E-2 }

      include ERV::DistributionBehavior
    end
  end

  with 'mixture of mixtures' do
    let(:distribution) do
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
      expect{ distribution.sample }.not.to raise_exception(ArgumentError).and(! be_nil)
    end
  end
end
