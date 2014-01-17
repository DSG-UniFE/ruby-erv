if RUBY_PLATFORM == 'java'
  require 'java'
  java_import org.apache.commons.math3.distribution.UniformRealDistribution
end

require 'erv/distribution'


module ERV

  class GpdDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:scale] and opts[:shape]
      scale    = opts[:scale].to_f
      shape    = opts[:shape].to_f
      location = opts[:location].try(:to_f) || 0.0

      if RUBY_PLATFORM == 'java'
        # create uniform distribution
        d = UniformRealDistribution.new(@rng, 0.0, 1.0,
                UniformRealDistribution::DEFAULT_INVERSE_ABSOLUTE_ACCURACY)
        # setup sampling function
        @func = Proc.new {
          # this algorithm was taken from wikipedia
          u = 1.0 - d.sample
          location + (scale * ((u ** (-shape)) - 1.0) / shape)
        }
      else
        # setup sampling function
        @func = Proc.new {
          # this algorithm was taken from wikipedia
          u = 1.0 - @rng.uniform
          location + (scale * ((u ** (-shape)) - 1.0) / shape)
        }
      end
    end
  end

end
