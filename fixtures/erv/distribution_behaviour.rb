module ERV
  module DistributionBehavior
    def self.included(base)
      base.it 'should allow sampling' do
        expect{ distribution.sample }.not.to raise_exception(ArgumentError).and(! be_nil)
      end

      base.it 'should have the expected mean and variance' do
        # sample_mean = samples.inject(0.0) { |s, x| s + x } / num_samples.to_f
        sample_mean = samples.sum / num_samples.to_f
        distribution_mean = distribution.mean
        expect(sample_mean).to be_within(epsilon * distribution_mean).of(distribution_mean)

        sample_variance = samples.map{ |x| (x - sample_mean) **2 }.sum / num_samples.to_f
        distribution_variance = distribution.variance
        expect(sample_variance).to be_within(epsilon * distribution_variance).of(distribution_variance)
      end
    end
  end
  # def samples { num_samples.times.map { distribution.sample } }
  # def epsilon { 5E-3 }
  # def num_samples { 1_000_000 }
end
