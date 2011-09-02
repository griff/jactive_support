require 'jactive_support/core_ext/map/hash'

module java::util::Map #:nodoc:
  include JactiveSupport::CoreExtensions::Map::Hash
  Hash.included_modules.find_all {|m| m.name.start_with?('ActiveSupport::CoreExtensions::') }.each {|m| include m}
end