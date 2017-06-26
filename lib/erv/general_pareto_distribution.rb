require 'erv/distribution'
require 'erv/support/try'


module ERV

  # See https://en.wikipedia.org/wiki/Generalized_Pareto_distribution
  class GpdDistribution < Distribution
    attr_accessor :mean, :variance

    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:scale] and opts[:shape]
      @scale    = opts[:scale].to_f
      @shape    = opts[:shape].to_f
      @location = opts[:location].try(:to_f) || 0.0

      @mean = if @shape < 1.0
        @location + @scale / (1.0 - @shape)
      else
        Infinity
      end

      @variance = if @shape < 0.5
        (@scale ** 2.0) / (((1.0 - @shape) ** 2) * (1.0 - 2 * @shape))
      else
        Infinity
      end
    end

    def sample
      u = 1.0 - @rng.rand
      if @shape == 0.0
        @location - @scale * Math::ln(u)
      else
        @location + (@scale * ((u ** (- @shape)) - 1.0) / @shape)
      end
    end

  end

end
