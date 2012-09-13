require 'jactive_support/java_ext/sql_date/conversions'

class java::sql::Date
  include JactiveSupport::JavaExtensions::SqlDate::Conversions
end