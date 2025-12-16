require 'erv/distribution'

module ERV
  class WeibullDistribution < Distribution
    def initialize(opts = {})
      super(opts)

      raise ArgumentError unless opts[:scale] and opts[:shape]

      @scale = opts[:scale].to_f
      @shape = opts[:shape].to_f

      raise ArgumentError, 'scale parameter must be greater than zero!' unless @scale > 0.0
      raise ArgumentError, 'shape parameter must be greater than zero!' unless @shape > 0.0
    end

    # For more details, see [KROESE11], section 4.2.18, algorithm 4.66 and
    def sample
      u = @rng.rand
      @scale * (-Math.log(1 - u))**(1.0 / @shape)
    end
  end
end
