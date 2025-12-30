require 'erv/distribution_behaviour'

describe ERV::GammaDistribution do
  it 'should require the scale and shape parameters' do
    expect{ ERV::GammaDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) { ERV::GammaDistribution.new(shape: 2.0, scale: 0.5) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
