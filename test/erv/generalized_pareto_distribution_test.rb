require 'erv/distribution_behaviour'

describe ERV::GpdDistribution do
  it 'should require the scale and shape parameters' do
    expect{ ERV::GpdDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'a (default) 2-parameter distribution' do
    let(:distribution) { ERV::GpdDistribution.new(scale: 1.0, shape: 0.3) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end

  with 'a 3-parameter distribution' do
    let(:distribution) { ERV::GpdDistribution.new(scale: 1.0,
                                                  shape: 0.3,
                                                  location: 1.0) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
