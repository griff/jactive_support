class Hash
  def to_java_map
    ret = java::util::HashMap.new(size)
    each_pair {|key, value| ret.put(key,value)}
    ret
  end
end

module java::util::Map #:nodoc:
  def to_java_map
    self
  end
end
