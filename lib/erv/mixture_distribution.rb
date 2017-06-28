require 'erv/constant_distribution'
require 'erv/discrete_uniform_distribution'
require 'erv/exponential_distribution'
require 'erv/gamma_distribution'
require 'erv/gaussian_distribution'
require 'erv/generalized_pareto_distribution'
require 'erv/geometric_distribution'
require 'erv/uniform_distribution'

module ERV

  class MixtureDistribution
    def initialize(confs, opts={})
      raise ArgumentError, "Please, provide at least 2 distributions!" unless confs.length >= 2

      @mixture = []
      weight_sum = 0.0
      while dist_conf = confs.shift
        # get weight ...
        weight = dist_conf.delete(:weight).to_f

        # ... and keep track of it
        weight_sum += weight

        # get amplitude
        amplitude = dist_conf.fetch(:amplitude) { 1.0 }

        # get distribution name
        dist_name = dist_conf.delete(:distribution).to_s

        # get class name that corresponds to the requested distribution
        klass_name = dist_name.split('_').push('distribution').map(&:capitalize).join

        # create distribution object
        distribution = ERV.const_get(klass_name).new(dist_conf)

        # add distribution to mixture
        @mixture << { amplitude: amplitude, weight: weight, distribution: distribution }
      end

      # normalize weights
      @mixture.each do |dist|
        dist[:weight] /= weight_sum
      end

      seed = opts[:seed]
      @mixture_sampler = (seed ? Random.new(seed) : Random.new)
    end

    def sample
      x = @mixture_sampler.rand

      # find index of distribution we are supposed to sample from
      i = 0
      while x > @mixture[i][:weight]
        x -= @mixture[i][:weight]
        i += 1
      end

      # return sample
      @mixture[i][:amplitude] * @mixture[i][:distribution].sample
    end

    def mean
      @mean ||= calculate_mean
    end

    def variance
      @variance ||= calculate_variance
    end

    private

      def calculate_mean
        @mixture.inject(0.0) do |s,x|
          s += (# the following formula was taken from
                # https://en.wikipedia.org/wiki/Mixture_Distribution#Moments
                x[:weight] *
                # remember: E[aX] = a E[X]
                x[:amplitude] * x[:distribution].mean)
        end
      end

      def calculate_variance
        @mixture.inject(0.0) do |s,x|
          s += (# the following formula was taken from
                # https://en.wikipedia.org/wiki/Mixture_Distribution#Moments
                x[:weight] *
                # remember: E[aX] = a E[X]
                ((x[:amplitude] * x[:distribution].mean - self.mean) ** 2 +
                # remember: Var(aX) = a**2 Var(X)
                 x[:amplitude] ** 2 * x[:distribution].variance))
        end
      end
  end

end
