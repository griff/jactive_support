class TrueClass
  def <=>(o)
    o.is_a?(TrueClass) ? 0 : -1
  end
end

class FalseClass
  def <=>(o)
    o.is_a?(FalseClass) ? 0 : 1
  end
end

class NilClass #:nodoc:
  def <=>(other)
    other.nil? ? 0 : -1;
  end
end

class String #:nodoc:
  def <=>(other)
    other.nil? ? 1 : super;
  end
end