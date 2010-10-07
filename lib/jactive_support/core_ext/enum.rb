class java::lang::Enum
  def self.value_of(value)
    value = value.to_s
    camel_name = value.camelize
    if(camel_name == value)
      self.valueOf(self, value)
    else
      self.getEnumConstants.find {|e| e.name == value || e.name == camel_name}
    end
  end
  
  def ===(other)
    other = other.to_s
    self.name == other || self.name == other.camelize
  end
end