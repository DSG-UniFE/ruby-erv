require 'erv/rng'

module ERV

  class Distribution
    def initialize(opts)
      # create RNG object
      if opts[:rng]
        @rng = opts[:rng]
      elsif opts[:seed]
        @rng = RNG.make_rng(opts[:seed])
      else
        raise ArgumentError, "No RNG or seed provided!"
      end
    end
  end

end
