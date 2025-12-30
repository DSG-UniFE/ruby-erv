require 'erv/distribution_behaviour'

describe ERV::GeometricDistribution do
  it 'should require at least a probability of success parameter' do
    expect{ ERV::GeometricDistribution.new }.to raise_exception(ArgumentError)
  end

  with 'sampling' do
    let(:distribution) { ERV::GeometricDistribution.new(probability_of_success: 0.5) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 5E-3 }

    include ERV::DistributionBehavior
  end
end
