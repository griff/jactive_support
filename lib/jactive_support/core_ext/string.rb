class String #:nodoc:
  def names
    self.to_s.split(/::/)
  end
  
  def parent_module
    self.to_s.sub(/::\w+$/, '')
  end
end
