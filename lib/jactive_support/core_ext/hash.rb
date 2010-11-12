require 'jactive_support/core_ext/hash/assert_valid_params'

class Hash
  def to_java_map
    ret = Java::JavaUtil::HashMap.new(size)
    each_pair {|key, value| ret.put(key,value)}
    ret
  end
end