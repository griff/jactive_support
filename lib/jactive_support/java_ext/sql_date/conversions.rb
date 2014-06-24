require 'jactive_support/java_ext/date/conversions'

class java::sql::Date
  DATE_FORMATS = {
    :db           => "yyyy-MM-dd",
    :i18n         => lambda { |clazz, locale| clazz.i18n_formatter(locale) },
    :number       => "yyyyMMdd",
    :full         => lambda { |clazz, locale| clazz.date_instance(:full, locale) },
    :long         => lambda { |clazz, locale| clazz.date_instance(:long, locale) },
    :medium       => lambda { |clazz, locale| clazz.date_instance(:medium, locale) },
    :short        => lambda { |clazz, locale| clazz.date_instance(:short, locale) },
    :default      => lambda { |clazz, locale| clazz.date_instance(:default, locale) },
    :rfc822       => "EEE, dd MMM yyyy HH:mm:ss Z",
    :httpdate     => lambda { |clazz, locale|
      fmt = clazz.pattern_formatter("EEE, dd MMM yyyy HH:mm:ss z", locale || 'EN')
      fmt.time_zone = 'GMT'.to_java_time_zone
      fmt
    }
  }

  def to_java_sqldate
    self
  end
  
  def acts_like_time?
    false
  end
end
