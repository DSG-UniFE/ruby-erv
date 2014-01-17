require 'erv/distribution'

module ERV

  class ConstantDistribution < Distribution
    def initialize(opts)
      super(opts)

      raise ArgumentError unless opts[:value]
      val = opts[:value].to_f
      @func = Proc.new { val }
    end
  end

end
