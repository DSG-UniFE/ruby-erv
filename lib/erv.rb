require 'rubygems'
require 'bundler/setup'

if RUBY_PLATFORM == 'java'
  require 'jbundler'
end

require 'erv/version'
require 'erv/random_variable'
