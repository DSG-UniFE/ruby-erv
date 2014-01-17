require 'erv/constant_distribution'
require 'erv/discrete_uniform_distribution'
require 'erv/exponential_distribution'
require 'erv/gamma_distribution'
require 'erv/gaussian_distribution'
require 'erv/general_pareto_distribution'
require 'erv/geometric_distribution'
require 'erv/uniform_distribution'


module ERV

  class RandomVariable
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
      @first = args.delete(:first_value)
      @most_recent = @first || 0.0
      @var = RandomVariable.new(args)
    end

    def next
      @most_recent += @var.next
    end
  end

end
