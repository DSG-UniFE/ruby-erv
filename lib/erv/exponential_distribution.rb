require 'erv/distribution'
require 'erv/support/try'


module ERV

  class ExponentialDistribution < Distribution
    attr_reader :mean, :variance

    def initialize(opts)
      super(opts)

      @rate = opts[:rate].try(:to_f)
      raise ArgumentError unless @rate and @rate > 0.0

      @mean = 1 / @rate
      @variance = @mean ** 2
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
