if RUBY_PLATFORM == 'java'
  require 'java'
  JGammaDistribution = org.apache.commons.math3.distribution.GammaDistribution
end

require 'erv/distribution'


module ERV

  class GammaDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:rate] and opts[:shape]
      scale = 1 / opts[:rate].to_f
      shape = opts[:shape].to_f

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = JGammaDistribution.new(@rng, shape, scale,
                JGammaDistribution::DEFAULT_INVERSE_ABSOLUTE_ACCURACY)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        @func = Proc.new { @rng.gamma(shape, scale) }
      end
    end
  end

end
