class NilClass #:nodoc:
  def break
    self
  end
  
#  def to_java
#    nil
#  end
  def <=>(other)
    other.nil? ? 0 : -1;
  end
end