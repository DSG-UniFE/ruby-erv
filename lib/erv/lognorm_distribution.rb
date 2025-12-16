require 'erv/distribution'

module ERV
  class LogNormDistribution < Distribution
    def initialize(opts = {})
      super(opts)

      raise ArgumentError, 'mu is required' unless opts[:mu]
      raise ArgumentError, 'sigma is required' unless opts[:sigma]
      raise ArgumentError, 'sigma must be greater than zero' unless opts[:sigma].to_f > 0.0

      @mu = opts[:mu].to_f
      @sigma = opts[:sigma].to_f

      # From Handbook of Monte Carlo Methods [KROESE11], section 4.2.10, pag 121
      @gaussian_dist = GaussianDistribution.new(mean: @mu, sd: @sigma)
    end

    def sample
      # just sample from @gaussian_dist and exponentiate the result
      Math.exp(@gaussian_dist.sample) # just sample from @gaussian_dist and exponentiate the res    Math.exp(@gaussian_dist.sample)))
    end

    def mean
      Math.exp(@mu + 0.5 * @sigma**2)
    end

    def variance
      Math.exp(2 * @mu + @sigma**2) * (Math.exp(@sigma**2) - 1)
    end
  end
end
