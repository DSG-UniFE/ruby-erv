require 'erv/rng'

module ERV

  class Distribution
    def initialize(opts)
      # create RNG object
      @rng = RNG.make_rng(opts[:seed])
    end

    def sample
      @func.call
    end
  end

end
