require 'test_helper'

require 'erv/gamma_distribution'

describe ERV::GammaDistribution do

  let (:num_samples) { 10000 }

  it 'should require the scale and shape parameters' do
    lambda do
      ERV::GammaDistribution.new()
    end.must_raise ArgumentError
  end

  context 'with a shape greater than one' do

    let :gsgtone do
      ERV::GammaDistribution.new(shape: 2.0, scale: 0.5)
    end

    context 'sampling' do

      it 'should allow sampling' do
        gsgtone.sample
      end

    end

    context 'moments' do
      let :samples do
        0.upto(num_samples).collect { gsgtone.sample }
      end

      it 'should have the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon gsgtone.mean, 0.05
      end

      it 'should have the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - gsgtone.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon gsgtone.variance, 0.05
      end

    end
  end

end
