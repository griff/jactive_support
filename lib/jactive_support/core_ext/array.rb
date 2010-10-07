class Array
  def to_java_list
    ret = Java::JavaUtil::ArrayList.new(size)
    each {|value| ret.add(value)}
    ret
  end
end