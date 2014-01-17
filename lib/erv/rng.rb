if RUBY_PLATFORM == 'java'
  require 'java'
  java_import org.apache.commons.math3.random.MersenneTwister
else
  require 'gsl'
end


module ERV

  class RNG
    def self.make_rng(seed = nil)
      # if not explicitly provided, seed is taken from the (lower quality)
      # pseudo-random Kernel::rand generator
      if RUBY_PLATFORM == 'java'
        # this is a somewhat ugly workaround in order to avoid ambibuities in
        # the constructor method that will be called (we basically explicit the
        # signature of the constructor that we want to use)
        constructor = org.apache.commons.math3.random.MersenneTwister.java_class.constructor(Java::long)
        rng = constructor.new_instance(seed || Kernel::rand(2**31 - 1))
      else
        rng = seed ?
          GSL::Rng.alloc(GSL::Rng::MT19937, seed) :
          GSL::Rng.alloc(GSL::Rng::MT19937, Kernel::rand(2**31 - 1))
      end
    end
  end

end
