require 'erv/distribution_behaviour'

describe ERV::ExponentialDistribution do
  it 'should require the rate parameter' do
    expect{ ERV::ExponentialDistribution.new() }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) { ERV::ExponentialDistribution.new(rate: 20.0) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end

end
