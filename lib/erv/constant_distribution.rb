require 'erv/distribution'

module ERV

  class ConstantDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:value]
      @val = opts[:value].to_f
    end

    def mean
      @val
    end

    def variance
      0.0
    end

    def sample
      @val
    end
  end

end
