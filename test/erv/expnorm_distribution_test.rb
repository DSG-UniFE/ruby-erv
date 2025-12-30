require 'erv/distribution_behaviour'

describe ERV::ExpNormDistribution do
  let(:num_samples) { 100_000 }

  with 'initialization' do
    it 'requires mu, sigma and lambda' do
      expect{ ERV::ExpNormDistribution.new }.to raise_exception(ArgumentError)
      expect{ ERV::ExpNormDistribution.new(mu: 0, sigma: 1) }.to raise_exception(ArgumentError)
    end

    it 'raises on invalid parameters' do
      expect{ ERV::ExpNormDistribution.new(mu: 0, sigma: 0, lambda: 1) }.to raise_exception(ArgumentError)
      expect{ ERV::ExpNormDistribution.new(mu: 0, sigma: 1, lambda: -1) }.to raise_exception(ArgumentError)
    end
  end

  with 'sampling' do
    let(:distribution) { ERV::ExpNormDistribution.new(mu: 10.0, sigma: 5.0, lambda: 0.2) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
