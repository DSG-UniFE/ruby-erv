require 'erv/distribution'


module ERV
  # See https://en.wikipedia.org/wiki/Generalized_Pareto_distribution
  class GpdDistribution < Distribution
    attr_accessor :mean, :variance

    def initialize(opts={})
      super(opts)

      raise ArgumentError unless opts[:scale] and opts[:shape]
      @scale    = opts[:scale].to_f
      @shape    = opts[:shape].to_f
      @location = opts.fetch(:location, 0.0).to_f

      @mean = if @shape < 1.0
        @location + @scale / (1.0 - @shape)
      else
        Float::Infinity
      end

      @variance = if @shape < 0.5
        (@scale ** 2.0) / (((1.0 - @shape) ** 2) * (1.0 - 2 * @shape))
      else
        Float::Infinity
      end
    end

    def sample
      u = 1.0 - @rng.rand
      if @shape.abs < 1E-15 # numerically stable check if @shape == 0.0
        @location - @scale * Math::log(u)
      else
        @location + (@scale * ((u ** (- @shape)) - 1.0) / @shape)
      end
    end
  end
end
