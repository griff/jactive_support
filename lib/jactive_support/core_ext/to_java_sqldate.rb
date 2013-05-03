require 'jactive_support/core_ext/to_java_date'
class Date
  def to_java_sqldate
    to_java_date.to_java_sqldate
  end
end
class Time
  def to_java_sqldate
    to_java_date.to_java_sqldate
  end
end
class ActiveSupport::TimeWithZone
  def to_java_sqldate
    to_java_date.to_java_sqldate
  end
end
class String
  def to_java_sqldate
    to_datetime.to_java_sqldate
  end
end