require 'erv/distribution'


module ERV
  # We refer to the formulation of the Gamma distribution adopted by [KROESE11]:
  #
  # f(x) = \frac{\lambda^{\alpha} x^{\alpha - 1} e^{-\lambda x}}{\Gamma(\alpha)}
  #
  # with \alpha > 0 being the shape parameter, \lambda > 0 being the scale
  # parameter, and x > 0.
  #
  # (Note that, unlike [KROESE11] Wikipedia refers to the \beta parameter as the "rate".)
  class GammaDistribution < Distribution
    attr_accessor :mean, :variance

    def initialize(opts={})
      super(opts)

      raise ArgumentError unless opts[:scale] and opts[:shape]
      @scale = opts[:scale].to_f
      @shape = opts[:shape].to_f

      raise ArgumentError, "scale parameter must be greater than zero!" unless @scale > 0.0
      raise ArgumentError, "shape parameter must be greater than zero!" unless @shape > 0.0

      @mean = @shape / @scale
      @variance = @shape / (@scale ** 2)
    end

    # We use Marsaglia and Tsang's sampling algorithm
    #
    # For more details, see [KROESE11], section 4.2.6, algorithm 4.33 and 
    # http://www.hongliangjie.com/2012/12/19/how-to-generate-gamma-random-variables/
    def sample
      gamrand(@shape, @scale)
    end

    private

      def gamrand(shape, scale)
        if shape >= 1.0
          d = shape - 1.0 / 3
          c = 1.0 / Math::sqrt(9 * d)
          ok = false
          until ok do
            # Use box-muller algorithm (see [KROESE11], section 4.2.11, algorithm
            # 4.47) to obtain z ~ N(0,1).
            u_1 = @rng.rand
            u_2 = @rng.rand
            z = Math::sqrt(-2.0 * Math::log(u_1)) * Math::cos(2.0 * Math::PI * u_2)
            if z > -1.0 / c
              v = (1.0 + c * z) ** 3
              u = @rng.rand
              ok = Math::log(u) <= (0.5 * (z**2) + d - d * v + d * Math::log(v))
            end
          end
          d * v / scale;
        else # 0 < @shape < 1
          gamrand(shape + 1.0, scale) * (@rng.rand ** (1 / shape))
        end
      end

  end

end
