module ERV

  class Distribution
    def initialize(opts={})
      # use provided RNG or create a new one
      if opts[:rng]
        @rng = opts[:rng]
      elsif opts[:seed]
        @rng = Random.new(opts[:seed])
      else
        @rng = Random.new
      end
    end
  end

end
