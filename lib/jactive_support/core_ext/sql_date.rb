require 'active_support/core_ext/date/behavior'
require 'jactive_support/core_ext/sql_date/conversions'

class Java::JavaSql::Date
  include ActiveSupport::CoreExtensions::Date::Behavior
  include JactiveSupport::CoreExtensions::SqlDate::Conversions
  
  def acts_like_time?
    false
  end
end