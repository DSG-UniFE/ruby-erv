# Load Apache Commons Math 3.3 jar if we're using JRuby
if RUBY_PLATFORM =~ /java/
  JARS_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', 'jars'))
  Dir["#{JARS_DIR}/*.jar"].each do |jar|
    $CLASSPATH << jar unless $CLASSPATH.include?(jar)
  end
end

require 'erv/version'
require 'erv/random_variable'
