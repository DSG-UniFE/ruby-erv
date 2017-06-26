require 'erv/distribution'


module ERV

  # We adopt the following version of the geometric distribution:
  #
  #   Pr(X = k) = (1 - p) ^ {k-1} * p
  #
  # See: https://en.wikipedia.org/wiki/Geometric_distribution
  class GeometricDistribution < Distribution
    attr_accessor :mean, :variance

    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:probability_of_success]
      @p = opts[:probability_of_success].to_f

      @mean = 1.0 / @p
      @variance = (1.0 - @p) / (@p ** 2)

      @ln_1_minus_p = Math::log(1 - @p)
    end

    def sample
      u = @rng.rand
      (Math::log(u) / @ln_1_minus_p).ceil
    end

  end

end
