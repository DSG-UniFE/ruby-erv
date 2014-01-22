##
# Object#try extension
#
# From rails:
#   * https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/object/try.rb

class Object
  alias_method :try, :__send__
end

class NilClass
  def try(*args)
    nil
  end
end
