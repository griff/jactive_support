class Date
  def to_java_date
    java.util.Date.new((to_time.tv_sec*1000).to_i)
  end
end
class Time
  def to_java_date
    java.util.Date.new((tv_sec*1000).to_i)
  end
end
class ActiveSupport::TimeWithZone
  def to_java_date
    java.util.Date.new((tv_sec*1000).to_i)
  end
end
class Java::JavaUtil::Date
  def to_java_date
    self
  end
end
class String
  def to_java_date
    to_datetime.to_java_date
  end
end