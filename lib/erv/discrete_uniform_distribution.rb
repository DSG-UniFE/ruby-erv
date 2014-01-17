if RUBY_PLATFORM == 'java'
  require 'java'
  java_import org.apache.commons.math3.distribution.UniformIntegerDistribution
end

require 'erv/distribution'


module ERV

  class DiscreteUniformDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:max_value]
      max = opts[:max_value].to_i
      min = opts[:min_value].try(:to_i) || 0

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = UniformIntegerDistribution.new(@rng, min, max)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        @func = Proc.new { min + @rng.uniform_int(max-min) }
      end
    end
  end

end
