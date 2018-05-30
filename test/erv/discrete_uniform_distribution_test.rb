require 'test_helper'

require 'erv/discrete_uniform_distribution'

describe ERV::DiscreteUniformDistribution do

  let (:num_samples) { 10000 }

  it 'should require at least a maximum parameter' do
    lambda do
      ERV::DiscreteUniformDistribution.new()
    end.must_raise ArgumentError
  end


  context 'a (default) 1-parameter distribution' do

    let :zero_to_sixty do
      ERV::DiscreteUniformDistribution.new(max_value: 60)
    end

    context 'sampling' do

      it 'should allow sampling' do
        zero_to_sixty.sample
      end

    end

    context 'moments' do
      let :samples do
        0.upto(num_samples).collect { zero_to_sixty.sample }
      end

      it 'should have the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon zero_to_sixty.mean, 0.05
      end

      it 'should have the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - zero_to_sixty.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon zero_to_sixty.variance, 0.05
      end

    end
  end

  context 'a 2-parameter distribution' do

    let :ten_to_ninety do
      ERV::DiscreteUniformDistribution.new(min_value: 10, max_value: 90)
    end

    context 'sampling' do

      it 'should allow sampling' do
        ten_to_ninety.sample
      end

    end

    context 'moments' do

      let :samples do
        0.upto(num_samples).collect { ten_to_ninety.sample }
      end

      it 'should have the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon ten_to_ninety.mean, 0.05
      end

      it 'should have the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - ten_to_ninety.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon ten_to_ninety.variance, 0.05
      end

    end
  end

end
