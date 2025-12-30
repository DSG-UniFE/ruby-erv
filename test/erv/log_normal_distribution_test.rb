require 'erv/distribution_behaviour'

describe ERV::LogNormDistribution do
  it 'should require the mu and sigma parameters' do
    expect{ ERV::LogNormDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) { ERV::LogNormDistribution.new(mu: 0.0, sigma: 0.25) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
