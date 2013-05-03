require 'jactive_support/java_ext/map/hash'

module java::util::Map #:nodoc:
  include JactiveSupport::JavaExtensions::Map::Hash
  Hash.included_modules.find_all {|m| m.name.start_with?('ActiveSupport::CoreExtensions::') }.each {|m| include m}
end