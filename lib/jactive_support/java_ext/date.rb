require 'jactive_support/java_ext/date/calculations'
require 'jactive_support/java_ext/date/conversions'

class java::util::Date
  include JactiveSupport::JavaExtensions::Date::Calculations
  include JactiveSupport::JavaExtensions::Date::Conversions

  FULL_STYLE = java::text::DateFormat::FULL
  LONG_STYLE = java::text::DateFormat::LONG
  MEDIUM_STYLE = java::text::DateFormat::MEDIUM
  SHORT_STYLE = java::text::DateFormat::SHORT
  DEFAULT_STYLE = java::text::DateFormat::DEFAULT
  
  STYLE = {
    :full => FULL_STYLE,
    :long => LONG_STYLE,
    :medium => MEDIUM_STYLE,
    :short => SHORT_STYLE,
    :default => DEFAULT_STYLE
  }
  
  def self.date_time_instance(date_style=:default, time_style=:default, locale=nil)
    java::text::DateFormat.getDateTimeInstance(STYLE[date_style], STYLE[time_style], locale.to_locale)
  end

  def self.time_instance(time_style=:default, locale=nil)
    java::text::DateFormat.getTimeInstance(STYLE[time_style], locale.to_locale)
  end

  def self.date_instance(date_style=:default, locale=nil)
    java::text::DateFormat.getDateInstance(STYLE[date_style], locale.to_locale)
  end
end