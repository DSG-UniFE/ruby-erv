require 'erv/constant_distribution'
require 'erv/discrete_uniform_distribution'
require 'erv/exponential_distribution'
require 'erv/gamma_distribution'
require 'erv/gaussian_distribution'
require 'erv/generalized_pareto_distribution'
require 'erv/geometric_distribution'
require 'erv/mixture_distribution'
require 'erv/uniform_distribution'
require 'erv/support/try'


module ERV

  class RandomVariable

    extend Forwardable

    def_delegators :@dist, :mean, :variance

    def initialize(opts)
      # get distribution name
      dist_name = opts[:distribution].try(:to_s)

      # get class name that corresponds to the requested distribution
      klass_name = dist_name.split('_').push('distribution').map(&:capitalize).join

      # create distribution object
      @dist = ERV.const_get(klass_name).new(opts)
    end

    def next
      @dist.sample
    end
  end


  class SequentialRandomVariable
    def initialize(args)
      first = args[:first_value]
      @most_recent = first.nil? ? 0.0 : first
      @var = RandomVariable.new(args.reject{|k,v| k == :first_value })
    end

    def next
      @most_recent += @var.next
    end
  end

end
