require 'java'
require File.expand_path('../shared/version', __FILE__)
require File.expand_path('../shared/fixtures', __FILE__)

require 'jactive_support/java_ext/map/constructor'
class java::util::HashMap
  include JactiveSupport::JavaExtensions::Map::Constructor
end

class Object
  # The following helpers provide a level of indirection for running the specs
  # against a Hash implementation that has a different name than Hash.

  # Returns the Hash class.
  unless method_defined?(:hash_class)
    def hash_class
      java::util::LinkedHashMap
    end
  end

  unless method_defined?(:ruby_hash_class)
    def ruby_hash_class
      Hash
    end
  end

  # Returns a new instance of hash_class.
  def new_hash(*args, &block)
    if block
      r = hash_class.new
      r.default = block
      r
    elsif args.size == 1
      value = args.first
      if value.is_a?(Hash) or value.is_a?(hash_class)
        r = hash_class.new
        r.putAll(value)
        r
      else
        r = hash_class.new
        r.default = value
        r
      end
    else
      r = hash_class.new
      args.each_slice(2) {|key,val| r.put(key,val)}
      r
    end
  end
end
