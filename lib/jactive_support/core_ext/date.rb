require 'active_support/core_ext/time/behavior'
require 'jactive_support/core_ext/date/calculations'
require 'jactive_support/core_ext/date/conversions'

class Java::JavaUtil::Date
  include ActiveSupport::CoreExtensions::Time::Behavior
  include JactiveSupport::CoreExtensions::Date::Calculations
  include JactiveSupport::CoreExtensions::Date::Conversions
end