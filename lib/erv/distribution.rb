module ERV

  class Distribution

    DEFAULT_SEED = 12345
    def initialize(opts={})
      # use provided RNG or create a new one
      if opts[:rng]
        @rng = opts[:rng]
      elsif opts[:seed]
        @rng = Random.new(opts[:seed])
      else
        @rng = Random.new(DEFAULT_SEED)
      end
    end
  end

end
