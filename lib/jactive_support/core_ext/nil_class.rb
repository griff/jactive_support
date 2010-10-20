class NilClass #:nodoc:
  def <=>(other)
    other.nil? ? 0 : -1;
  end
end