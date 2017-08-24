require 'erv/distribution'
require 'erv/support/try'


module ERV

  class UniformDistribution < Distribution
    def initialize(opts={})
      super(opts)

      raise ArgumentError unless opts[:max_value]
      max = opts[:max_value].to_f
      @min = opts[:min_value].try(:to_f) || 0.0
      @range = max - @min
    end

    def sample
      # starting from a random variable X ~ U(0,1), which is provided by the
      # RNG, we can obtain a random variable Y ~ U(a,b) through location-scale
      # transformation: Y = a + (b-a) X. see [KROESE11], section 3.1.2.2.
      @min + @range * @rng.rand
    end
  end

end
