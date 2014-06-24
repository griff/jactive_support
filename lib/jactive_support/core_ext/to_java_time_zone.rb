require 'jactive_support/java_ext/to_java_time_zone'

class String
  def to_java_time_zone
    java::util::TimeZone.getTimeZone(self)
  end
end

class Symbol
  def to_java_time_zone
    to_s.to_java_time_zone
  end
end