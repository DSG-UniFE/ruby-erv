require 'erv/distribution_behaviour'

describe ERV::GaussianDistribution do
  it 'should require the scale and shape parameters' do
    expect{ ERV::GaussianDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) { ERV::GaussianDistribution.new(mean: 20.0, sd: 0.5) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 5E-3 }

    include ERV::DistributionBehavior
  end
end
