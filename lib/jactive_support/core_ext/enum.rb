class ::Java::JavaLang::Enum
  def self.find_value_of(value)
    value = value.to_s
    camel_name = value.camelize
    if(camel_name == value)
      self.valueOf(value)
    else
      self.java_class.to_java.getEnumConstants.find {|e| e.name == value || e.name == camel_name}
    end
  end
  
  def ===(other)
    other = other.to_s
    self.name == other || self.name == other.camelize
  end
end