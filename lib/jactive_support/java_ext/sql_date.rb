require 'active_support/core_ext/date/behavior'
require 'jactive_support/java_ext/sql_date/conversions'

class java::sql::Date
  include ActiveSupport::CoreExtensions::Date::Behavior
  include JactiveSupport::JavaExtensions::SqlDate::Conversions
end