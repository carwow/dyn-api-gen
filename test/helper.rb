$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

require 'rubygems'
require 'bundler/setup'
require 'dyn_api_gen'
require 'test/unit'

def reject(condition, message="Expected condition to be unsatisfied")
  assert !condition, message
end
