if RUBY_PLATFORM == 'java'
  require 'java'
  JGeometricDistribution = org.apache.commons.math3.distribution.GeometricDistribution
end


module ERV

  class GeometricDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:probability_of_success]
      p = opts[:probability_of_success].to_f

      if RUBY_PLATFORM == 'java'
        # create distribution
        d = JGeometricDistribution.new(@rng, p)
        # setup sampling function
        @func = Proc.new { d.sample }
      else
        # setup sampling function
        #
        # WARNING: I HAVEN'T TRIED THIS CODE!!!
        # Note that GSL implements the shifted version of the geometric
        # distribution, so we might need to change the result (removing 1?)
        @func = Proc.new { @rng.geometric(p) }
      end
    end
  end

end
