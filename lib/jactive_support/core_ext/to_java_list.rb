class Array
  def to_java_list
    ret = java::util::ArrayList.new(size)
    each {|value| ret.add(value)}
    ret
  end
end

module java::util::List
  def to_java_list
    self
  end
end