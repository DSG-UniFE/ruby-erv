require 'erv/distribution'

module ERV
  class ExpNormDistribution < Distribution
    def initialize(opts = {})
      super(opts)

      raise ArgumentError, 'mu is required'     unless opts[:mu]
      raise ArgumentError, 'sigma is required'  unless opts[:sigma]
      raise ArgumentError, 'lambda is required' unless opts[:lambda]
      raise ArgumentError, 'sigma must be > 0'  if opts[:sigma].to_f <= 0
      raise ArgumentError, 'lambda must be > 0' if opts[:lambda].to_f <= 0

      @mu     = opts[:mu].to_f
      @sigma  = opts[:sigma].to_f
      @lambda = opts[:lambda].to_f # rate = 1/mean_exponential

      @gaussian = GaussianDistribution.new(mean: @mu, sd: @sigma)
      @exponential = ExponentialDistribution.new(rate: @lambda)
    end

    def sample
      @gaussian.sample + @exponential.sample
    end

    # Theoretical Mean E[X]: μ + 1/λ
    def mean
      @mu + 1.0 / @lambda
    end

    # Theoretical Variance: σ² + 1/λ²
    def variance
      @sigma**2 + 1.0 / (@lambda**2)
    end

    def k
      @lambda / @sigma
    end
  end
end
