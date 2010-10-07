class Symbol
  def to_locale
    to_s.to_locale
  end
  
#  def to_java
#    to_s.to_java
#  end
  def flash_with_enum(other)
    if other.java_kind_of? ::Java::JavaLang::Enum
      other.name == self.to_s || other.name == self.to_s.camelize
    else
      flash_without_enum(other)
    end
  end
  alias :flash_without_enum :===
  alias :=== :flash_with_enum

end