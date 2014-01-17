if RUBY_PLATFORM == 'java'
  require 'java'
  java_import org.apache.commons.math3.distribution.UniformRealDistribution
end

require 'erv/distribution'


module ERV

  class UniformDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:max_value]
      max = opts[:max_value].to_f
      min = opts[:min_value].try(:to_f) || 0.0

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = UniformRealDistribution.new(@rng, min, max,
                UniformRealDistribution::DEFAULT_INVERSE_ABSOLUTE_ACCURACY)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        @func = Proc.new { @rng.flat(min, max) }
      end
    end
  end

end
