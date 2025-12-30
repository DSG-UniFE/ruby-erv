require 'erv/distribution_behaviour'

describe ERV::DiscreteUniformDistribution do
  it 'should require at least a maximum parameter' do
    expect{ ERV::DiscreteUniformDistribution.new }.to raise_exception(ArgumentError)
  end


  with 'a (default) 1-parameter distribution' do
    let(:distribution) { ERV::DiscreteUniformDistribution.new(max_value: 60) }

    let(:num_samples) { 300_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end


  with 'a 2-parameter distribution' do
    let(:distribution) { ERV::DiscreteUniformDistribution.new(min_value: 10, max_value: 90) }

    let(:num_samples) { 200_000 }
    let(:samples) { num_samples.times.map { distribution.sample } }
    let(:epsilon) { 1E-2 }

    include ERV::DistributionBehavior
  end
end
