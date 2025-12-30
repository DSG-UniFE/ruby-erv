require 'erv/distribution_behaviour'

describe ERV::BetaDistribution do
  with 'initialization' do
    it 'should require the alpha and beta parameters' do
      expect{ ERV::BetaDistribution.new(alpha: 0.0) }.to raise_exception(ArgumentError)
      expect{ ERV::BetaDistribution.new(beta: 0.0) }.to raise_exception(ArgumentError)
      expect{ ERV::BetaDistribution.new(alpha: -1.0, beta: 0.0) }.to raise_exception(ArgumentError)
      expect{ ERV::BetaDistribution.new(alpha: 0.0, beta: -1.0) }.to raise_exception(ArgumentError)
    end
  end

  with 'sampling' do
    let(:distribution) { ERV::BetaDistribution.new(alpha: 2.0, beta: 5.0) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
