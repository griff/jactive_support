require 'jactive_support/java_ext/number'

class Numeric
  def to_formatted_s(format=:default, locale=nil)
    self.to_java.to_formatted_s(format, locale)
  end
end
