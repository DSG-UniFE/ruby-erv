if RUBY_PLATFORM == 'java'
  require 'java'
  java_import org.apache.commons.math3.distribution.NormalDistribution
end

require 'erv/distribution'


module ERV

  class GaussianDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:mean] and opts[:sd]
      mean = opts[:mean].to_f
      sd   = opts[:sd].to_f

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = NormalDistribution.new(@rng, mean, sd,
                NormalDistribution::DEFAULT_INVERSE_ABSOLUTE_ACCURACY)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        @func = Proc.new { mean + @rng.ran_gaussian(sd) }
      end
    end
  end

end
