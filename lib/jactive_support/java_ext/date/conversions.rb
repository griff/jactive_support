require 'active_support/core_ext/object/blank'
require 'jactive_support/java_ext/date/localize'

class java::util::Date
  DATE_FORMATS = {
    :db           => "yyyy-MM-dd HH:mm:ss.SSS",
    :i18n         => lambda { |clazz, locale| clazz.i18n_formatter(locale: locale) },
    :number       => "yyyyMMddHHmmssSSS",
    :time         => "HH:mm:ss",
    :full         => lambda { |clazz, locale| clazz.date_time_instance(:full, :full, locale) },
    :long         => lambda { |clazz, locale| clazz.date_time_instance(:long, :long, locale) },
    :medium       => lambda { |clazz, locale| clazz.date_time_instance(:medium, :medium, locale) },
    :short        => lambda { |clazz, locale| clazz.date_time_instance(:short, :short, locale) },
    :default      => lambda { |clazz, locale| clazz.date_time_instance(:default, :default, locale) },
    :rfc822       => "EEE, dd MMM yyyy HH:mm:ss Z",
    :httpdate     => lambda { |clazz, locale|
      fmt = clazz.pattern_formatter("EEE, dd MMM yyyy HH:mm:ss z", locale || 'EN')
      fmt.time_zone = 'GMT'.to_java_time_zone
      fmt
    }
  }

  def self.formatter(format = :i18n, options = {})
    formatter = self::DATE_FORMATS[format] || formatter(:default, options)
    if formatter.respond_to?(:call)
      if formatter.arity == 2
        formatter = formatter.call(self, options[:locale])
      else
        formatter = formatter.call(self)
      end
    elsif formatter.is_a?(String)
      formatter = self.pattern_formatter(formatter, options[:locale])
    end

    if options[:time_zone] && formatter.respond_to?(:time_zone)
      formatter.time_zone = options[:time_zone].to_java_time_zone
    end

    formatter
  end

  def self.format(format = :i18n, options = {})
    formatter(format, options).to_pattern
  end

  # Converts to a formatted string. See DATE_FORMATS for builtin formats.
  #
  # This method is aliased to <tt>to_s</tt>.
  #
  #   time = java::util::Date.new         # => Thu Jan 18 06:10:17 CST 2007
  #
  #   time.to_formatted_s(:time)          # => "06:10:17"
  #   time.to_s(:time)                    # => "06:10:17"
  #
  #   time.to_formatted_s(:db)            # => "2007-01-18 06:10:17.100"
  #   time.to_formatted_s(:number)        # => "20070118061017100"
  #   time.to_formatted_s(:short)         # => "18 Jan 06:10"
  #   time.to_formatted_s(:long)          # => "January 18, 2007 06:10"
  #   time.to_formatted_s(:rfc822)        # => "Thu, 18 Jan 2007 06:10:17 -0600"
  #
  # == Adding your own time formats to +to_formatted_s+
  # You can add your own formats to the Time::DATE_FORMATS hash.
  # Use the format name as the hash key and either a strftime string
  # or Proc instance that takes a time argument as the value.
  #
  #   # config/initializers/time_formats.rb
  #   Time::DATE_FORMATS[:month_and_year] = "%B %Y"
  #   Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
  def to_formatted_s(format = :i18n, options = {})
    return to_default_s unless self.class::DATE_FORMATS[format]
    self.class.formatter(format, options).format(self)
  end
  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s

  # Converts a java.util.Date object to a string using the given format pattern.
  # The pattern syntax is from java.text.SimpleDateFormat
  #
  #  my_time = java.util.Date.new  # => Mon Nov 12 22:59:51 -0500 2007
  #  my_time.strformat('yyyy MMMMM') # => "2007 November"
  def strformat(pattern, options = {})
    formatter = self.class.pattern_formatter(pattern, options[:locale])
    if options[:time_zone] && formatter.respond_to?(:time_zone)
      formatter.time_zone = options[:time_zone].to_java_time_zone
    end
    formatter.format(self)
  end

  # Converts a java.util.Date object to a ruby Date, dropping hour, minute, and second precision.
  #
  #   my_time = java.util.Date.new  # => Mon Nov 12 22:59:51 -0500 2007
  #   my_time.to_date     # => Mon, 12 Nov 2007
  def to_date
    to_time.to_date
  end

  # Converts a java.util.Date instance to a Time.
  #
  # ==== Examples
  #   date = java.util.Date.new  # => Mon Nov 12 22:59:51 -0500 2007
  #   date.to_time               # => Mon Nov 12 22:59:51 -0500 2007
  def to_time
    ::Time.at(self.getTime/1000)
  end

  # Converts a java.util.Date instance to a Ruby DateTime instance, preserving UTC offset.
  #
  #   my_time = Time.now    # => Mon Nov 12 23:04:21 -0500 2007
  #   my_time.to_datetime   # => Mon, 12 Nov 2007 23:04:21 -0500
  #
  #   your_time = Time.parse("1/13/2009 1:13:03 P.M.")  # => Tue Jan 13 13:13:03 -0500 2009
  #   your_time.to_datetime                             # => Tue, 13 Jan 2009 13:13:03 -0500
  def to_datetime
    to_time.to_datetime
  end
  
  def to_java_sqldate
    java::sql::Date.new(time)
  end
  
  def httpdate
    to_formatted_s(:httpdate)
  end

  def acts_like_time?
    true
  end
end
