require 'test_helper'

require 'erv/generalized_pareto_distribution'

describe ERV::GpdDistribution do

  let (:num_samples) { 200000 }

  it 'should require scale and shape parameters' do
    lambda do
      ERV::GpdDistribution.new()
    end.must_raise ArgumentError
  end


  context 'a (default) 2-parameter distribution' do

    let :gpd_2params do
      ERV::GpdDistribution.new(scale: 1.0, shape: 0.3)
    end

    context 'sampling' do

      it 'should allow sampling' do
        gpd_2params.sample
      end

    end

    context 'moments' do
      let :samples do
        0.upto(num_samples).collect { gpd_2params.sample }
      end

      it 'should have the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon gpd_2params.mean, 0.1
      end

      it 'should have the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - gpd_2params.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon gpd_2params.variance, 0.1
      end

    end
  end


  context 'a 3-parameter distribution' do

    let :gpd_3params do
      ERV::GpdDistribution.new(scale: 1.0,
                               shape: 0.3,
                               location: 1.0)
    end

    context 'sampling' do

      it 'should allow sampling' do
        gpd_3params.sample
      end

    end

    context 'moments' do
      let :samples do
        0.upto(num_samples).collect { gpd_3params.sample }
      end

      it 'should have the expected mean' do
        sample_mean = samples.inject(0.0) {|s,x| s += x } / num_samples.to_f
        sample_mean.must_be_within_epsilon gpd_3params.mean, 0.1
      end

      it 'should have the expected variance' do
        sample_variance = samples.inject(0.0) {|s,x| s += (x - gpd_3params.mean) ** 2 } / num_samples.to_f
        sample_variance.must_be_within_epsilon gpd_3params.variance, 0.1
      end

    end
  end
end
