class java::lang::Enum
  def self.find_value_of(value)
    value = value.to_s
    camel_name = value.camelize
    if(camel_name == value)
      self.valueOf(value)
    else
      ret = self.java_class.to_java.getEnumConstants.find {|e| e.name == value || e.name == camel_name}
      #raise java::lang::IllegalArgumentException.new("No enum const class #{java_class.name}.#{value}") unless ret
      self.valueOf(value) unless ret # Above does not throw the exception the same way as java code
      ret
    end
  end
  
  def ===(other)
    other = other.to_s
    self.name == other || self.name == other.camelize
  end
end
