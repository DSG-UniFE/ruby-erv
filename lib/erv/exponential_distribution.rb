require 'erv/distribution'


module ERV

  class ExponentialDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:mean]
      @mean = opts[:mean].to_f
    end

    def sample
      # starting from a random variable X ~ U(0,1), which is provided by the
      # RNG, we can obtain a random variable Y ~ Exp(\lambda), with mean = 1 /
      # \lambda, through the transformation: Y = - (1 / \lambda) ln X. see
      # [GROESE11], section 4.2.3.
      - @mean * Math.log(@rng.rand)
    end
  end

end
