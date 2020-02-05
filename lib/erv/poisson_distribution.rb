require 'erv/distribution'
require 'erv/support/try'


module ERV

  class PoissonDistribution < Distribution
    attr_reader :mean, :variance

    def initialize(opts={})
      super(opts)

      @lambda = opts[:lambda]
      raise ArgumentError unless @lambda.class == Integer

      @mean = @lambda 
      @variance = @lambda
    end

    # Junhao, based on Knuth
    # for large values of lambda
    # https://en.wikipedia.org/wiki/Poisson_distribution
    def sample
      lambda_left = @lambda.to_f
      k = 0.0
      p = 1.0
      step = 500 # safe step value
      loop do
        k += 1.0
        p = p * @rng.rand
        while p < 1.0 && lambda_left > 0.0 do
          if lambda_left > step
            p = p * Math::exp(step)
            lambda_left -= step
          else
            p = p * Math::exp(lambda_left)
            lambda_left = 0
          end
        end
        break if p <= 1.0
      end
      (k - 1).to_f
    end
  end
  end
