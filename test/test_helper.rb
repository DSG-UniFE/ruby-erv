require 'minitest/autorun'
require 'minitest/spec'
require 'minitest-spec-context'

require 'minitest/reporters'
Minitest::Reporters.use!

# Required to setup classpath for Apache Commons Math 3.3-SNAPSHOT in JRuby
require 'erv'
