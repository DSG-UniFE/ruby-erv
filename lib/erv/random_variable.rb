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

    def initialize(args={})
      # get distribution name
      dist_name = args[:distribution].try(:to_s)

      # get class name that corresponds to the requested distribution
      klass_name = dist_name.split('_').push('distribution').map(&:capitalize).join

      # create distribution object
      @dist = ERV.const_get(klass_name).new(args[:args])
    end

    def next
      @dist.sample
    end

    alias_method :sample, :next

  end


  class SequentialRandomVariable

    def initialize(args={})
      first = args.delete(:first_value)
      raise ArgumentError, "First value must be provided!" if first.nil?
      @most_recent = first.to_f
      @var = RandomVariable.new(args)
    end

    def next
      @most_recent += @var.next
    end

    alias_method :sample, :next

  end

end
