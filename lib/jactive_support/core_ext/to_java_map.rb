class Hash
  def to_java_map
    self
  end
end

module java::util::Map #:nodoc:
  def to_java_map
    self
  end
end
