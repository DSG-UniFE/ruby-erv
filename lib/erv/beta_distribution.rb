require 'erv/distribution'

module ERV
  class BetaDistribution < Distribution
    def initialize(opts = {})
      raise ArgumentError, 'alpha is required' unless opts[:alpha]
      raise ArgumentError, 'beta is required' unless opts[:beta]
      raise ArgumentError, 'alpha must be greater than zero' unless opts[:alpha].to_f > 0.0
      raise ArgumentError, 'beta must be greater than zero' unless opts[:beta].to_f > 0.0

      # Parameters alpha and beta must be greater than zero
      @alpha = opts[:alpha]
      @beta = opts[:beta]
      @loc = opts[:loc] || 0.0
      @scale = opts[:scale] || 1.0

      @gamma_alpha = GammaDistribution.new(shape: @alpha, scale: 1.0)
      @gamma_beta  = GammaDistribution.new(shape: @beta, scale: 1.0)
    end

    # The handbook describes many method to sample from a Beta distribution.
    # We could use Gamma RVs or event sampling u ~ N(0,1) and then X = U ** (1 / alpha)
    def sample
      # let's use gamma random variables
      x = @gamma_alpha.sample
      y = @gamma_beta.sample
      @loc + x / (x + y) * @scale
    end

    def mean
      @loc + @alpha.to_f / (@alpha + @beta) * @scale
    end

    def variance
      core_var = (@alpha.to_f * @beta) / (((@alpha + @beta)**2) * (@alpha + @beta + 1))
      core_var * (@scale**2)
    end
  end
end
