require 'active_support/core_ext/time/behavior'
require 'jactive_support/core_ext/date/calculations'
require 'jactive_support/core_ext/date/conversions'

class Java::JavaUtil::Date
  include ActiveSupport::CoreExtensions::Time::Behavior
  include JactiveSupport::CoreExtensions::Date::Calculations
  include JactiveSupport::CoreExtensions::Date::Conversions

  FULL_STYLE = ::Java::JavaText::DateFormat::FULL
  LONG_STYLE = ::Java::JavaText::DateFormat::LONG
  MEDIUM_STYLE = ::Java::JavaText::DateFormat::MEDIUM
  SHORT_STYLE = ::Java::JavaText::DateFormat::SHORT
  DEFAULT_STYLE = ::Java::JavaText::DateFormat::DEFAULT
  
  STYLE = {
    :full => FULL_STYLE,
    :long => LONG_STYLE,
    :medium => MEDIUM_STYLE,
    :short => SHORT_STYLE,
    :default => DEFAULT_STYLE
  }
  
  def self.date_time_instance(date_style=:default, time_style=:default, locale=nil)
    ::Java::JavaText::DateFormat.getDateTimeInstance(STYLE[date_style], STYLE[time_style], locale.to_locale)
  end

  def self.time_instance(time_style=:default, locale=nil)
    ::Java::JavaText::DateFormat.getTimeInstance(STYLE[time_style], locale.to_locale)
  end

  def self.date_instance(date_style=:default, locale=nil)
    ::Java::JavaText::DateFormat.getDateInstance(STYLE[date_style], locale.to_locale)
  end
end