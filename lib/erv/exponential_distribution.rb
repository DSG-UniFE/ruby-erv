if RUBY_PLATFORM == 'java'
  require 'java'
  JExponentialDistribution = org.apache.commons.math3.distribution.ExponentialDistribution
end

require 'erv/distribution'


module ERV

  class ExponentialDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:mean]
      mean = opts[:mean].to_f

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = JExponentialDistribution.new(@rng, mean,
                JExponentialDistribution::DEFAULT_INVERSE_ABSOLUTE_ACCURACY)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        @func = Proc.new { @rng.exponential(mean) }
      end
    end
  end

end
