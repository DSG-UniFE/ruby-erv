require 'erv/distribution'
require 'erv/support/try'


module ERV

  class DiscreteUniformDistribution < Distribution
    attr_reader :mean, :variance

    def initialize(opts={})
      super(opts)

      raise ArgumentError unless opts[:max_value]
      @max = opts[:max_value].to_i
      @min = opts[:min_value].try(:to_i) || 0
      @mean = (@max + @min) / 2.0
      # See https://en.wikipedia.org/wiki/Discrete_uniform_distribution
      @variance = ((@max - @min + 1).to_f ** 2 - 1.0) / 12.0
    end

    def sample
      (@min.to_f + @rng.rand * (@max - @min + 1).to_f).floor
    end
  end

end
